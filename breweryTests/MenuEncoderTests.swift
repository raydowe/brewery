//
//  MenuEncoderTests.swift
//  breweryTests
//
//  Created by Raymond Dowe on 19/04/2021.
//

import XCTest

class MenuEncoderTests: XCTestCase {

    func testEncode() throws {
        
        var beers = [Beer]()
        beers.append(Beer(id: 1, type: .barrelAged))
        beers.append(Beer(id: 2, type: .classic))
        beers.append(Beer(id: 3, type: .classic))
        beers.append(Beer(id: 4, type: .barrelAged))
        beers.append(Beer(id: 5, type: .classic))
        
        let menuEncoder = MenuEncoder()
        let output = menuEncoder.encode(beers: beers)
        XCTAssert(output == "B C C B C")
    }
}
