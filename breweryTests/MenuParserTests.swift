//
//  MenuParserTests.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import XCTest
@testable import brewery

class MenuParserTests: XCTestCase {
    
    //func setUpWithError() throws {
    //}

    func testSimpleSolution() throws {
        let input = """
5
1 B 3 C 5 C
2 C 3 B 4 C
5 B
"""
        let (count, customerPreferences) = try MenuParser.parse(input: input)
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
    
    /*func testNoSolution() throws {
        let input = """
1
1 C
1 B
"""
        let menu = BrewMenu.solve(input: input)
        XCTAssertNil(menu)
    }
    
    func testLargeSolution() throws {
        let input = """
5
2 B
5 C
1 C
5 C 1 C 4 B
3 C
5 C
3 C 5 C 1 C
3 C
2 B
5 C 1 C
2 B
5 C
4 B
5 C 4 B
"""
        let expected = "C B C B C"
        let menu = BrewMenu.solve(input: input)
        XCTAssertEqual(menu, expected)
    }
    
    func testSmallSolution() throws {
        let input = """
2
1 C 2 B
1 B
"""
        let expected = "B B"
        let menu = BrewMenu.solve(input: input)
        XCTAssertEqual(menu, expected)
    }*/
}
