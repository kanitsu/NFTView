//
//  ListViewModel.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var hasMore: Bool = true
    
    @Published var dataSource: [ListItemViewModel] = []
    @Published var balance: Double = 0.0
    @Published var address = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
    
    private let assetsFetcher = AssetsFetcher()
    private let balanceFetcher = BalanceFetcher()
    private var disposables = Set<AnyCancellable>()
    private var nextCursor: String = ""
    
    func addMoreContent() {
        if !loading {
            do {
                loading = true
                try self.fetchAssets(forAddress: self.address)
            }
            catch {
                fatalError("\(error.localizedDescription)")
            }
        }
    }
    
    func fetchAssets(forAddress address: String) throws {
        var publisher : AnyPublisher<OpenseaData, APIError>
        do {
            try publisher = self.assetsFetcher.getAssets(forAddress: address, withCursor: nextCursor)
        }
        catch {
            throw error
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                        case .failure:
                            break
                        case .finished:
                            self.loading = false
                            break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    let playlist = response.assets.map(ListItemViewModel.init)
                    self.dataSource.append(contentsOf: playlist)
                    guard let nextPageCursor = response.next else {
                        self.nextCursor = ""
                        self.hasMore = false
                        return
                    }
                    self.nextCursor = nextPageCursor
                }
            )
            .store(in: &disposables)
    }
    
    func getBalance() {
        do {
            try self.fetchBalance(forAddress: self.address)
        }
        catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func fetchBalance(forAddress address: String) throws {
        var publisher : AnyPublisher<EVMData, APIError>
        do {
            try publisher = self.balanceFetcher.getBalance(forAddress: self.address)
        }
        catch {
            throw error
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { value in
                    switch value {
                        case .failure:
                            break
                        case .finished:
                            break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    let walletInfo = BalanceViewModel(info: response)
                    self.balance = walletInfo.balance
                }
            )
            .store(in: &disposables)
    }
}
