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
}
