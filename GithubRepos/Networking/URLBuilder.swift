//
//  URLBuilder.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation


struct APIPath {
    static let scheme = "https"
    static let baseURL = "api.github.com"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIPath.scheme
        components.host = APIPath.baseURL
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}





