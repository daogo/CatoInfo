//
//  File.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 06/11/2020.
//

import Foundation
 
struct Cat: Decodable {
    let breeds: [CatBreed]
    let height : Int
    let id : String
    let url : String
    let width : Int
}
