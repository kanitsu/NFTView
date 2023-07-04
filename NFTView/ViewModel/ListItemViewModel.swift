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
        return self.item.id
    }
    
    var thumbnailUrl: String {
        return self.item.image_thumbnail_url ?? "Invalid thumbnail URL"
    }
    
    var name: String {
        return self.item.name ?? "Item Name"
    }
    
    var rawData: OpenseaData.Asset {
        return self.item
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
