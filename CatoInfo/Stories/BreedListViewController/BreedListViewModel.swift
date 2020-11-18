//
//  BreedListViewModel.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 21/10/2020.
//

import Foundation
import RxSwift
import RxCocoa

final class BreedListViewModel {
    
    let title = NSLocalizedString("BreedListView.title", comment: "")
    
    private let apiClient : CatApiClientProtocol
    
    public let loadingInProcess = BehaviorSubject<Bool>(value: true)
    public let cellsViewModels = BehaviorRelay<[CatBreedTableViewCellViewModel]>(value: [])
    public let error : PublishSubject<Error> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    init(apiClient : CatApiClientProtocol = CatApiClient() ) {
        self.apiClient = apiClient
        
    }
    
    public func getData() {
        self.fetchBreedsCellsViewModels().observeOn(MainScheduler.instance).subscribe { (cellsViewModels) in
            self.cellsViewModels.accept(cellsViewModels)
        } onError: { (error) in
            self.loadingInProcess.onNext(false)
            self.error.onNext(error)
        }.disposed(by: disposeBag)
        
        
    }
    
    private func fetchBreedsCellsViewModels() -> Observable<[CatBreedTableViewCellViewModel]> {
        loadingInProcess.onNext(true)
        
        return apiClient.getData(from: CatEndpoint.breeds).map { $0.map {
            self.loadingInProcess.onNext(false)
            return CatBreedTableViewCellViewModel(breed: $0)
            }
        }
    }
    
}
