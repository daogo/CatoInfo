//
//  Breeds.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 21/10/2020.
//

import Foundation


struct CatBreed: Decodable {
    let id: String
    let name: String
    let temperament: String
    let life_span: String
    let alt_names: String?
    let wikipedia_url: String?
    let origin: String
    let description: String
    let weight_imperial: String?
    let weight : Weight
    
//    0-1
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressed_tail: Int
    let short_legs: Int
    let hypoallergenic: Int
    
//    1-5
    let adaptability : Int?
    let affection_level : Int?
    let child_friendly : Int?
    let dog_friendly : Int?
    let energy_level : Int?
    let grooming : Int?
    let health_issues : Int?
    let intelligence : Int?
    let shedding_level : Int?
    let social_needs : Int?
    let stranger_friendly : Int?
    let vocalisation : Int?
}



