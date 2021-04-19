//
//  MenuEncoder.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

internal protocol IMenuEncoder {
    func encode(beers: [Beer]) -> String
}

internal class MenuEncoder: IMenuEncoder {
    
    func encode(beers: [Beer]) -> String {
        let characters = beers.map { $0.type.rawValue }
        let output = characters.joined(separator: " ")
        return output
    }
    
}
