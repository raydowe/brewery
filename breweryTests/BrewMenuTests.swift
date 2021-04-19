//
//  breweryTests.swift
//  breweryTests
//
//  Created by Raymond Dowe on 19/04/2021.
//

import XCTest
//@testable import brewery

class BrewMenuTests: XCTestCase {

    var brewsMenu: BrewsMenu?
    
    override func setUpWithError() throws {
        self.brewsMenu = BrewsMenu(parser: BeerRequestParser(), menuCreator: MenuCreator(), encoder: MenuEncoder())
    }
    
    func testSimpleSolution() throws {
        let input = """
5
1 B 3 C 5 C
2 C 3 B 4 C
5 B
"""
        let output = try self.brewsMenu!.generate(input: input)
        XCTAssertEqual(output, "C C C C B")
    }
    
    func testNoSolution() throws {
        let input = """
1
1 C
1 B
"""
        let output = try self.brewsMenu!.generate(input: input)
        XCTAssertNil(output)
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
        let output = try self.brewsMenu!.generate(input: input)
        XCTAssertEqual(output, "C B C B C")
    }
    
    func testSmallSolution() throws {
        let input = """
2
1 C 2 B
1 B
"""
        let expected = "B B"
        let output = try self.brewsMenu!.generate(input: input)
        XCTAssertEqual(output, expected)
    }
}
