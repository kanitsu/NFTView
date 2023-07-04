//
//  Util.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation
import Combine

func reformatDate(input: String) -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    guard let date = isoDateFormatter.date(from: input) else {
        return input
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "GMT+8")
    return dateFormatter.string(from: date)
}

func fetch<T>(
    with session: URLSession,
    andComponents components: URLComponents
) -> AnyPublisher<T, APIError> where T: Decodable {
    guard let url = components.url else {
        let error = APIError.network(description: "Couldn't create URL")
        return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
        .mapError { error in
            .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .eraseToAnyPublisher()
}

func post<T>(
    with session: URLSession,
    andComponents components: URLComponents,
    andBody body: Data
) -> AnyPublisher<T, APIError> where T: Decodable {
    guard let url = components.url else {
        let error = APIError.network(description: "Couldn't create URL")
        return Fail(error: error).eraseToAnyPublisher()
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = body
    return session.dataTaskPublisher(for: request)
        .mapError { error in
            .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .eraseToAnyPublisher()
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    // print("The data: \(data.toString()!)")
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}

enum APIError: Error {
    case setting(description: String)
    case parsing(description: String)
    case network(description: String)
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
