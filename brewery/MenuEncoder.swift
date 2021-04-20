//
//  MenuEncoder.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

internal protocol IMenuEncoder {
    func encode(menu: Menu) -> String
}

internal class MenuEncoder: IMenuEncoder {
    
    func encode(menu: Menu) -> String {
        let characters = menu.beers.map { $0.type.rawValue }
        let output = characters.joined(separator: " ")
        return output
    }
    
}
