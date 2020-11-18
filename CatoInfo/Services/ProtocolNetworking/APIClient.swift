//
//  APIClient.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 20/10/2020.
//
//

import Foundation
import RxSwift

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?) -> Observable<T>
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
                guard let json = json else {
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onError(APIError.invalidData)
                    }
                    return
                }
                if let value = decode(json) {
                      observer.onNext(value)
                      observer.onCompleted()
                } else {
                    observer.onError(APIError.jsonParsingFailure)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel() }
            
        }
    }
    
    
    func fetchError<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
//                TO SHOW ERROR
                observer.onError(APIError.jsonParsingFailure)
            }
            task.resume()
            return Disposables.create {
                task.cancel() }
            
        }
    }
}
