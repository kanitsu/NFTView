//
//  OpenseaAPI.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation
import Combine

class AssetsFetcher {
    internal let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

protocol AssetsFetchable {
    func getAssets(
        forAddress address: String,
        withCursor cursor: String?
    ) throws -> AnyPublisher<OpenseaData, APIError>
}

extension AssetsFetcher: AssetsFetchable {
    func getAssets(
        forAddress address: String,
        withCursor cursor: String?
    ) throws -> AnyPublisher<OpenseaData, APIError> {
        var urlComp: URLComponents
        do {
            try urlComp = getAssetsItem(forAddress: address, withCursor: cursor)
        } catch {
            throw error
        }
        
//        if let url = urlComp.url {
//            let urlString = url.absoluteString
//            print("Full URL: \(urlString)")
//        }
        
        return fetch(with: session, andComponents: urlComp)
    }
}

private extension AssetsFetcher {
    func getAssetsItem(
        forAddress address: String,
        withCursor cursor: String?
    ) throws -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "testnets-api.opensea.io"
        components.path = "/api/v1/assets"
        components.queryItems = [
            URLQueryItem(name: "owner", value: address),
            URLQueryItem(name: "cursor", value: cursor),
        ]
        //https://testnets-api.opensea.io/api/v1/assets?owner=0x85fD692D2a075908079261F5E351e7fE0267dB02&cursor=LXBrPTE2MDQzMTczNQ==
        return components
    }
}
