//
//  Beer.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

enum BrewType {
    case classic
    case barrelAged
}

internal struct Beer {
    let id: Int
    let type: BrewType
}
