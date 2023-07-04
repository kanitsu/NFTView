//
//  NFTItem.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation


struct OpenseaData: Codable {
    var assets: [Asset]
    var next: String?
    var previous: String?
    
    struct Asset: Codable {
        let id: Int
        let image_url: String?
        let image_thumbnail_url: String?
        let name: String?
        let description: String?
        let permalink: String?
        let collection: Collection?
    }
    
    struct Collection: Codable {
        let name: String?
    }
}
