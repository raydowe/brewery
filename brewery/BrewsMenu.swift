//
//  MenuCreator.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

internal class BrewsMenu {

    let parser: IBeerRequestParser
    let menuCreator: IMenuCreator
    let encoder: IMenuEncoder
    
    init(parser: IBeerRequestParser, menuCreator: IMenuCreator, encoder: IMenuEncoder) {
        self.parser = parser
        self.menuCreator = menuCreator
        self.encoder = encoder
    }
    
    public func generate(input: String) throws -> String? {
        let (beerCount, customerPreferences) = try parser.parse(input: input)
        let beers = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences)
        let output = encoder.encode(beers: beers)
        return output
    }
    
}
