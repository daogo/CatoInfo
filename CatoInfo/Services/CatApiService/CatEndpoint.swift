//
//  CatEndpoint.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 06/11/2020.
//


import Foundation

enum CatEndpoint {
    case breeds
    case cat(breedId: String)
}

extension CatEndpoint: Endpoint {
    
    var base: String {
        return "https://api.thecatapi.com"
    }
    
    var path: String {
        switch self {
        case .breeds: return "/v1/breeds"
        case .cat: return "/v1/images/search"
        }
    }
    
    var queryItems : [URLQueryItem] {
        switch self {
        case .breeds: return []
        case .cat(let breedId):
            return [URLQueryItem(name: "limit", value: "5"),
                    URLQueryItem(name: "breed_id", value: breedId)]
        }

    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
    
}
