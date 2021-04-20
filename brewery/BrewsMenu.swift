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
        guard let menu = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences) else {
            return ""
        }
        let output = encoder.encode(menu: menu)
        return output
    }
    
}
