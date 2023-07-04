//
//  ListView.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    
    let tapOnNFT: (OpenseaData.Asset) -> Void
    
    var body: some View {
        ScrollView {
            Text("Address: \(self.viewModel.address)")
                .font(.footnote)
            Text("Ξ \(self.viewModel.balance) ETH")
            Spacer()
            LazyVStack {
                ForEach(Array(stride(from: 0, to: self.viewModel.dataSource.count - 1, by: 2)), id: \.self) { index in
                    ListRowView(viewModelLeft: self.viewModel.dataSource[index], viewModelRight: self.viewModel.dataSource[index + 1], tapOnNFT: tapOnNFT)
                }
                // In case the data number is odd, render the last item
                if self.viewModel.dataSource.count % 2 == 1 {
                    ListRowView(viewModelLeft: self.viewModel.dataSource[self.viewModel.dataSource.count - 1], viewModelRight: nil, tapOnNFT: tapOnNFT)
                }
                if self.viewModel.hasMore {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                        .onAppear {
                            self.viewModel.addMoreContent()
                        }
                }
            }
        }
        .padding(5)
        .navigationBarTitle(Text("NFT Viewer"), displayMode: .inline)
        .onAppear {
            self.viewModel.getBalance()
        }
    }
}
