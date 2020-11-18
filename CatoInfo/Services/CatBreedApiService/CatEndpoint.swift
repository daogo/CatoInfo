//
//  CatFeed.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 22/10/2020.
//

import Foundation

enum CatBreedEndpoint {
    case breeds
    case cat(breedId: String)
}

extension CatBreedEndpoint: Endpoint {
    
    var base: String {
        return "https://api.thecatapi.com"
    }
    
    var path: String {
        switch self {
        case .breeds: return "/v1/breeds"
        case .cat: return "/v1/images/search"
        }
    }
    
    var parameters : [String : String] {
        switch self {
        case .breeds:
            return [:]
        case .cat(let breedId):
            return ["limit": "5",
                    "breed_id": breedId]
        }
    }
    
    var request: URLRequest {
        
        switch self {
        case .breeds:
            let url = urlComponents.url!
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
            
//            do {
//                print(parameters)
//                request.httpBody = try? JSONEncoder().encode(parameters)
//            } catch let error {
//                print(error)
//            }
            
            return request
            
        case .cat:
            let url = urlComponents.url!
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
            
            do {
                print(parameters)
                request.httpBody = try? JSONEncoder().encode(parameters)
            } catch let error {
                print(error)
            }
            
            return request
        
        }
        
    }

 }
