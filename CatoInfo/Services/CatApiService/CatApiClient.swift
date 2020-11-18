//
//  File.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 06/11/2020.
//

import Foundation
import RxSwift

protocol CatApiClientProtocol {
    func getData(from catFeedType: CatEndpoint) -> Observable<[CatBreed]>
    func getDataFor(breedId : String) -> Observable<[Cat]>
}

class CatApiClient : APIClient, CatApiClientProtocol  {
    
    func getDataFor(breedId: String) -> Observable<[Cat]> {
        return fetch(with: CatEndpoint.cat(breedId: breedId).request) { (json) -> [Cat] in
            if let items = json as? [Cat] {
                return items
            } else {
                return []
            }
        }
    }
    
    
    func getData(from catFeedType: CatEndpoint) -> Observable<[CatBreed]> {
        return fetch(with: catFeedType.request) { (json) -> [CatBreed] in
            if let breed = json as? [CatBreed] {
                return breed
            } else {
                return []
            }
        }
    }

    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
}
