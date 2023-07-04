//
//  ListCoordinator.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import SwiftUI

struct NFTCoordinator: View {
    @State private var selectedItemViewModel: DetailViewModel? = nil

    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView{
            VStack {
                ListView(tapOnNFT: { asset in
                    self.selectedItemViewModel = DetailViewModel(asset: asset)
                })
                if let item = self.selectedItemViewModel {
                    EmptyNavigationLink(destination: DetailView(selectedItemViewModel: item, permalinkAction: permalinkAction), selectedItem: $selectedItemViewModel)
                }
            }
        }
    }
    
    private func permalinkAction(url: URL?) {
        guard let url = url else { return }
        openURL(url)
    }
}
