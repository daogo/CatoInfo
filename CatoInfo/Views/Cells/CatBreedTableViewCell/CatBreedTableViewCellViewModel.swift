//
//  CatBreedTableViewCellViewModel.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 05/11/2020.
//

import Foundation

struct CatBreedTableViewCellViewModel {
    
    private let breed : CatBreed
    
    var displayName : String {
        return breed.name
    }
    
    var shortBreedDescription : String {
        return breed.temperament
    }
    
    init(breed: CatBreed) {
        self.breed = breed
    }
    
    public func getBreed() -> CatBreed {
        return breed
    }
}
