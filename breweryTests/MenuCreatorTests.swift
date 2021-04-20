//
//  BrewsCreator.swift
//  breweryTests
//
//  Created by Raymond Dowe on 19/04/2021.
//

import XCTest

class MenuCreatorTests: XCTestCase {

    func testSimpleMatch() throws {
        
        let beerCount = 2
        var customerPreferences = [CustomerPreference]()
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 1, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .classic)]))

        let menuCreator = MenuCreator()
        guard let beers = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences) else {
            XCTFail("Beers should not be nil")
            return
        }
        
        XCTAssert(beers.count == 2)
        XCTAssert(beers[0].id == 1)
        XCTAssert(beers[0].type == .classic)
        XCTAssert(beers[1].id == 2)
        XCTAssert(beers[1].type == .classic)
    }
    
    func testOneRoundMatch() throws {
        
        let beerCount = 2
        var customerPreferences = [CustomerPreference]()
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 1, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .barrelAged)]))

        let menuCreator = MenuCreator()
        guard let beers = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences) else {
            XCTFail("Beers should not be nil")
            return
        }
        
        XCTAssert(beers.count == 2)
        XCTAssert(beers[0].id == 1)
        XCTAssert(beers[0].type == .classic)
        XCTAssert(beers[1].id == 2)
        XCTAssert(beers[1].type == .barrelAged)
    }
    
    func testTwoRoundMatch() throws {
        
        let beerCount = 2
        var customerPreferences = [CustomerPreference]()
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 1, type: .barrelAged)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .barrelAged)]))

        let menuCreator = MenuCreator()
        guard let beers = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences) else {
            XCTFail("Beers should not be nil")
            return
        }
        
        XCTAssert(beers.count == 2)
        XCTAssert(beers[0].id == 1)
        XCTAssert(beers[0].type == .barrelAged)
        XCTAssert(beers[1].id == 2)
        XCTAssert(beers[1].type == .barrelAged)
    }
    
    func testNoMatch() throws {
        
        let beerCount = 2
        var customerPreferences = [CustomerPreference]()
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .barrelAged)]))

        let menuCreator = MenuCreator()
        let beers = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences)
        
        XCTAssertNil(beers)
    }
}
