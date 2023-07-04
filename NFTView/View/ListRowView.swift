//
//  ListRowView.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import SwiftUI

struct ListRowView: View {
    private let viewModelLeft: ListItemViewModel
    private let viewModelRight: ListItemViewModel?
    private let tapOnNFT: (OpenseaData.Asset) -> Void
    
    init(viewModelLeft: ListItemViewModel, viewModelRight: ListItemViewModel?, tapOnNFT: @escaping (OpenseaData.Asset) -> Void) {
        self.viewModelLeft = viewModelLeft
        self.viewModelRight = viewModelRight
        self.tapOnNFT = tapOnNFT
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ListItemView(viewModel: self.viewModelLeft, tapOnNFT: self.tapOnNFT)
            Spacer()
            if let rightModel = self.viewModelRight {
                ListItemView(viewModel: rightModel, tapOnNFT: self.tapOnNFT)
            } else {
                GeometryReader { geometry in
                    Spacer()
                        .frame(maxWidth: geometry.size.width, minHeight: geometry.size.height)
                }
            }
            Spacer()
        }
    }
}
