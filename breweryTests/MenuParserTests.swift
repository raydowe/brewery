//
//  MenuParserTests.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import XCTest
@testable import brewery

class MenuParserTests: XCTestCase {
    
    func testParsing() throws {
        let input = """
5
1 B 3 C 5 C
2 C 3 B 4 C
5 B
"""
        let beerRequestParser = BeerRequestParser()
        let (count, customerPreferences) = try beerRequestParser.parse(input: input)
        XCTAssertEqual(count, 5)
        XCTAssert(customerPreferences.count == 3)
        
        var customerPreference = customerPreferences[0]
        XCTAssert(customerPreference.beers.count == 3)
        XCTAssert(customerPreference.beers[0].id == 1)
        XCTAssert(customerPreference.beers[0].type == .barrelAged)
        XCTAssert(customerPreference.beers[1].id == 3)
        XCTAssert(customerPreference.beers[1].type == .classic)
        XCTAssert(customerPreference.beers[2].id == 5)
        XCTAssert(customerPreference.beers[2].type == .classic)
        
        customerPreference = customerPreferences[1]
        XCTAssert(customerPreference.beers.count == 3)
        XCTAssert(customerPreference.beers[0].id == 2)
        XCTAssert(customerPreference.beers[0].type == .classic)
        XCTAssert(customerPreference.beers[1].id == 3)
        XCTAssert(customerPreference.beers[1].type == .barrelAged)
        XCTAssert(customerPreference.beers[2].id == 4)
        XCTAssert(customerPreference.beers[2].type == .classic)
        
        customerPreference = customerPreferences[2]
        XCTAssert(customerPreference.beers.count == 1)
        XCTAssert(customerPreference.beers[0].id == 5)
        XCTAssert(customerPreference.beers[0].type == .barrelAged)
    }
}
