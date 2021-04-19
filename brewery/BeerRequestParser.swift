//
//  MenuParser.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

enum BeerRequestParserError: Error {
    case invalidInput
    case invalidBeerCount
    case invalidCustomerPreferences
    case invalidBrewType
}

internal protocol IBeerRequestParser {
    func parse(input: String) throws -> (Int, [CustomerPreference])
}

internal class BeerRequestParser: IBeerRequestParser {
    
    func parse(input: String) throws -> (Int, [CustomerPreference]) {
        let lines = parseLines(input: input)
        guard lines.count >= 2 else {
            throw BeerRequestParserError.invalidInput
        }
        let beerCount = try parseBeerCount(headerLine: lines[0])
        var customerPreferences = [CustomerPreference]()
        for index in 1..<lines.count {
            let line = lines[index]
            let customerPreference = try parseCustomerPreference(line: line)
            customerPreferences.append(customerPreference)
        }
        return (beerCount, customerPreferences)
    }
    
    private func parseLines(input: String) -> [String] {
        let lines = input.split(separator: "\n").map{ String($0) }
        return lines
    }
    
    private func parseBeerCount(headerLine: String) throws -> Int {
        guard let beerCount = Int(headerLine) else {
            throw BeerRequestParserError.invalidBeerCount
        }
        return beerCount
    }
    
    private func parseCustomerPreference(line: String) throws -> CustomerPreference {
        let characters = line.split(separator: " ").map{ String($0) }
        guard characters.count % 2 == 0 else {
            throw BeerRequestParserError.invalidCustomerPreferences
        }
        var beers = [Beer]()
        for index in stride(from: 0, to: characters.count - 1, by: 2) {
            guard let beerId = Int(characters[index]) else {
                throw BeerRequestParserError.invalidCustomerPreferences
            }
            let beerType = try beerTypeFor(character: characters[index + 1])
            let beer = Beer(id: beerId, type: beerType)
            beers.append(beer)
        }
        let customerPreference = CustomerPreference(beers: beers)
        return customerPreference
    }
    
    private func beerTypeFor(character: String) throws -> BrewType {
        guard let brewType = BrewType(rawValue: character.uppercased()) else {
            throw BeerRequestParserError.invalidBrewType
        }
        return brewType
    }
}
