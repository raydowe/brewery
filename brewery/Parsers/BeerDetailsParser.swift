//
//  BeerDetailsParser.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import Foundation

protocol IBeerDetailsParser {
    func parse(beerDetailsJSON: String) -> BeerDetailsJSON?
}

enum BeerDetailsParserError: Error {
    case BadJson
    case UnknownError
}

class BeerDetailsParser: IBeerDetailsParser {
    
    func parse(beerDetailsJSON: String) -> BeerDetailsJSON? {
        let jsonData = beerDetailsJSON.data(using: .utf8)!
        let beerDetails: [BeerDetailsJSON] = try! JSONDecoder().decode([BeerDetailsJSON].self, from: jsonData)
        return beerDetails.first
    }
}
