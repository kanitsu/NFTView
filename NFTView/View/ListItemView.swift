//
//  ListItemView.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import SwiftUI

struct ListItemView: View {
    private let viewModel: ListItemViewModel
    private let tapOnNFT: (OpenseaData.Asset) -> Void
    
    init(viewModel: ListItemViewModel, tapOnNFT: @escaping (OpenseaData.Asset) -> Void) {
        self.viewModel = viewModel
        self.tapOnNFT = tapOnNFT
    }
    
    var body: some View {
        VStack {
            Spacer()
            if self.viewModel.thumbnailUrl.hasSuffix(".svg") {
                GeometryReader { geometry in
                    SVGImageView(url: URL(string:self.viewModel.thumbnailUrl)!, size: CGSize(width: geometry.size.width, height: geometry.size.height))
                }
            } else {
                URLImage(url: URL(string: self.viewModel.thumbnailUrl))
            }
            Spacer()
            Text(self.viewModel.name)
        }
        .padding(5)
        .cornerRadius(20) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 3)
        )
        .onTapGesture {
            self.tapOnNFT(self.viewModel.rawData)
        }
    }
}
