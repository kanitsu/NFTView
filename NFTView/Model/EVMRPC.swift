//
//  EVMRPC.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation
import Combine

class BalanceFetcher {
    internal let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

protocol BalanceFetchable {
    func getBalance(
        forAddress address: String
    ) throws -> AnyPublisher<EVMData, APIError>
}

extension BalanceFetcher: BalanceFetchable {
    func getBalance(
        forAddress address: String
    ) throws -> AnyPublisher<EVMData, APIError> {
        var urlComp: URLComponents
        do {
            try urlComp = getBalanceUrl()
        } catch {
            throw error
        }
        
//        if let url = urlComp.url {
//            let urlString = url.absoluteString
//            print("Full URL: \(urlString)")
//        }
        
        let json = [
            "id": 1,
            "jsonrpc": "2.0",
            "method": "eth_getBalance",
            "params": [address, "latest"]
        ] as [String : Any]
        var jsonData: Data
        do {
            try jsonData = JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            throw error
        }
        
        return post(with: session, andComponents: urlComp, andBody: jsonData)
    }
}

private extension BalanceFetcher {
    func getBalanceUrl() throws -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ethereum-goerli.publicnode.com"
        //https://ethereum-goerli.publicnode.com
        return components
    }
}
