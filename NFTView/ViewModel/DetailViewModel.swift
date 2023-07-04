//
//  DetailViewModel.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let item: OpenseaData.Asset
    
    init(asset: OpenseaData.Asset) {
      self.item = asset
    }
    
    var id: Int {
        return item.id
    }
    
    var imageUrl: String {
        return item.image_url ?? "Invalid image URL"
    }
    
    var name: String {
        return item.name ?? "Item Name"
    }
    
    var description: String {
        return item.description ?? "Item Description"
    }
    
    var permalink: String {
        return item.permalink ?? "Invalid permalink URL"
    }
    
    var collection_name: String {
        guard let collection = item.collection else { return "Collection Name" }
        return collection.name ?? "Collection Name"
    }
}

extension DetailViewModel: Hashable {
  static func == (lhs: DetailViewModel, rhs: DetailViewModel) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
