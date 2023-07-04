//
//  DetailView.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel : DetailViewModel
    
    let permalinkAction : (URL?) -> Void
    
    init(selectedItemViewModel: DetailViewModel, permalinkAction: @escaping (URL?) -> Void) {
        self.viewModel = selectedItemViewModel
        self.permalinkAction = permalinkAction
    }
    
    var body: some View {
        Spacer()
        VStack {
            URLImage(url: URL(string: self.viewModel.imageUrl))
            GeometryReader { geometry in
                Text(self.viewModel.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, minHeight: geometry.size.height / 3.0)
                Spacer()
                Text(self.viewModel.description)
                    .lineLimit(8)
                    .position(x: geometry.size.width / 2.0, y: geometry.size.height * 1.8 / 3.0)
            }.padding(5)
            Spacer()
            Button(action: {
                self.permalinkAction(URL(string: self.viewModel.permalink))
            }) {
                Text("Permalink")
            }
            Spacer()
        }
        .padding(5)
        .navigationBarTitle(Text(self.viewModel.collection_name), displayMode: .inline)
    }
}
