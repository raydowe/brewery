//
//  BrewsCreator.swift
//  breweryTests
//
//  Created by Raymond Dowe on 19/04/2021.
//

import XCTest

class MenuCreatorTests: XCTestCase {

    func testMenuCreator() throws {
        
        let beerCount = 5
        var customerPreferences = [CustomerPreference]()
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .barrelAged)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 5, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 1, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 5, type: .classic), Beer(id: 1, type: .classic), Beer(id: 4, type: .barrelAged)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 3, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 5, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 3, type: .classic), Beer(id: 5, type: .classic), Beer(id: 1, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 3, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .barrelAged)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 5, type: .classic), Beer(id: 1, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 2, type: .barrelAged)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 5, type: .classic)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 4, type: .barrelAged)]))
        customerPreferences.append(CustomerPreference(beers: [Beer(id: 5, type: .classic), Beer(id: 4, type: .barrelAged)]))
        
        let menuCreator = MenuCreator()
        let beers = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences)
        
        XCTAssert(beers.count == 5)
        
        XCTAssert(beers[0].id == 1)
        XCTAssert(beers[0].type == .classic)
        
        XCTAssert(beers[1].id == 2)
        XCTAssert(beers[1].type == .classic)
        
        XCTAssert(beers[2].id == 3)
        XCTAssert(beers[2].type == .classic)
        
        XCTAssert(beers[3].id == 4)
        XCTAssert(beers[3].type == .classic)
        
        XCTAssert(beers[4].id == 5)
        XCTAssert(beers[4].type == .barrelAged)
    }
}
