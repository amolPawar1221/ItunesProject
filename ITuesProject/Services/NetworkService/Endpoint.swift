//
//  Endpoint.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func search(matching query: String, page: Int?, entity: EntityType) -> Endpoint {

        var queryItems: [URLQueryItem] = [URLQueryItem(name: "term", value: query),
                          URLQueryItem(name: "entity", value: entity.rawValue)]

        if let page = page {
            queryItems.append(URLQueryItem(name: "limit", value: "20"))
            queryItems.append(URLQueryItem(name: "offset", value: "\(page * 20)"))
        }
            return Endpoint(
                path: "/search",
                queryItems: queryItems)
    }
}

extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
