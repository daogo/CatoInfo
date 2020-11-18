//
//  CatBreedsService.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 21/10/2020.
//

import Foundation


import RxSwift

protocol DEPRECATEDCatBreedServiceProtocol {
    func fetchCatBreedsFromJson() -> Observable<[CatBreed]>
}

class DEPRECATEDCatBreedService : DEPRECATEDCatBreedServiceProtocol {
    func fetchCatBreedsFromJson() -> Observable<[CatBreed]> {

        return Observable.create { (observer) -> Disposable in

            guard let path = Bundle.main.path(forResource: "breed", ofType: "json") else {

                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create {}
            }

            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                do {
                    let breeds = try JSONDecoder().decode([CatBreed].self, from: data)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        observer.onNext(breeds)
                    }


                } catch {
                    observer.onError(error)
                }



            } catch(let error) {
                observer.onError(error)
            }

            return Disposables.create { }
        }
    }
    
    func fetchBreedsFromApi() -> Observable<[CatBreed]> {
        
        return Observable.create { (observer) -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URL(string: "mysoper url")!) { (data, response, error) in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let breeds = try JSONDecoder().decode([CatBreed].self, from: data)
                    observer.onNext(breeds)
                    
                } catch {
                    observer.onError(error)
                }
                
                
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
}
