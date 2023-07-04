//
//  ListItemViewModel.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation

struct ListItemViewModel: Identifiable {
    private let item: OpenseaData.Asset
    
    init(asset: OpenseaData.Asset) {
      self.item = asset
    }
    
    var id: Int {
        return item.id
    }
    
    var thumbnailUrl: String {
        return item.image_thumbnail_url ?? "Invalid thumbnail URL"
    }
    
    var name: String {
        return item.name ?? "Item Name"
    }
    
    var rawData: OpenseaData.Asset {
        return item
    }
}

extension ListItemViewModel: Hashable {
  static func == (lhs: ListItemViewModel, rhs: ListItemViewModel) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
