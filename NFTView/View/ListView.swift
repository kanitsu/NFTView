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
            Text("Balance: \(self.viewModel.balance)")
            Spacer()
            LazyVStack {
                ForEach(Array(stride(from: 0, to: viewModel.dataSource.count - 1, by: 2)), id: \.self) { index in
                    ListRowView(viewModelLeft: viewModel.dataSource[index], viewModelRight: viewModel.dataSource[index + 1], tapOnNFT: tapOnNFT)
                }
                // In case the data number is odd, render the last item
                if viewModel.dataSource.count % 2 == 1 {
                    ListRowView(viewModelLeft: viewModel.dataSource[viewModel.dataSource.count - 1], viewModelRight: nil, tapOnNFT: tapOnNFT)
                }
                if viewModel.hasMore {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                        .onAppear {
                            viewModel.addMoreContent()
                        }
                }
            }
        }
        .padding(5)
        .navigationBarTitle(Text("NFT Viewer"), displayMode: .inline)
        .onAppear {
            viewModel.getBalance()
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView(viewModel: ListViewModel())
//    }
//}
