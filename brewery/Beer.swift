//
//  Beer.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

enum BrewType: String {
    case classic = "C"
    case barrelAged = "B"
}

internal struct Beer: Equatable {
    let id: Int
    let type: BrewType
}
