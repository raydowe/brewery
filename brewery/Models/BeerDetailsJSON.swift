//
//  BeerDetailsJSON.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import Foundation

struct BeerDetailsJSON: Decodable {
    let id: Int
    let name: String
    let image_url: String
    let abv: Float
    let description: String

    let ingredients: IngredientJSON
    let method: MethodJSON
}

struct IngredientJSON: Decodable {
    let hops: [HopJSON]
    let malt: [MaltJSON]
}

struct HopJSON: Decodable {
    let name: String
}

struct MaltJSON: Decodable {
    let name: String
}

struct MethodJSON: Decodable {
    let mash_temp: [MashTempJSON]
    let fermentation: FermentationJSON
    let twist: String?
}

struct FermentationJSON: Decodable {
    let temp: TempJSON
}

struct MashTempJSON: Decodable {
    let temp: TempJSON
    let duration: Int?
}

struct TempJSON: Decodable {
    let value: Int
    let unit: String
}
