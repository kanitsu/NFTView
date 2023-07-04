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
        return self.item.id
    }
    
    var imageUrl: String {
        return self.item.image_url ?? "Invalid image URL"
    }
    
    var name: String {
        return self.item.name ?? "Item Name"
    }
    
    var description: String {
        return self.item.description ?? "Item Description"
    }
    
    var permalink: String {
        return self.item.permalink ?? "Invalid permalink URL"
    }
    
    var collection_name: String {
        guard let collection = self.item.collection else { return "Collection Name" }
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
