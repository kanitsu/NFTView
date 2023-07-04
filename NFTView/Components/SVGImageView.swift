//
//  SVGImageView.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation
import UIKit
import SwiftUI
import SVGKit

struct SVGImageView: UIViewRepresentable {
    var url:URL
    var size:CGSize
    
    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        uiView.contentMode = .scaleAspectFit
        uiView.image.size = size
    }
    
    func makeUIView(context: Context) -> SVGKFastImageView {
        let svgImage = SVGKImage(contentsOf: url)
        return SVGKFastImageView(svgkImage: svgImage ?? SVGKImage())
    }
}
