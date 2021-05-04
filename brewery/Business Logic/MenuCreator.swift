//
//  BrewsCreator.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

internal protocol IMenuCreator {
    func generateMenu(beerCount: Int, customerPreferences:[CustomerPreference]) -> Menu?
}

/**
 You run a Brewery, and there are a few different types of Beers you can prepare for
 customers. Each Beer can be either "Classic" or "Barrel Aged". You have a number of
 customers, and each has some Beers that they like, either classic or barrel aged. No
 customer will like more than one Barrel Aged Beer. You want to mix the Beers, so that:
  - There is just one batch for each type of Beers, and it's either Classic or Barrel Aged.
  - For each customer, there is at least one Beer they like.
  - You make as few Barrel Aged Beers as possible (because they are more expensive).
 */

internal class MenuCreator: IMenuCreator {
    
    internal func generateMenu(beerCount: Int, customerPreferences:[CustomerPreference]) -> Menu? {
        let idsOfUpgrades = idsOfBarrelPreferences(customerPreferences: customerPreferences)
        let menusToTry = generateMenus(beerCount: beerCount, upgradeIds: idsOfUpgrades)
        for menuToTry in menusToTry {
            if menuSatisfiesCustomers(menu: menuToTry, customerPreferences: customerPreferences) {
                return menuToTry
            }
        }
        return nil
    }
    
    private func generateMenus(beerCount: Int, upgradeIds: [Int]) -> [Menu] {
        var menus = [Menu]()
        let allPossibleUpgrades = possibleUpgrades(ids: upgradeIds)
        for possibleUpgrades in allPossibleUpgrades {
            let menuWithUpgrades = generateMenu(beerCount: beerCount, upgradeIDs: possibleUpgrades)
            menus.append(menuWithUpgrades)
        }
        return menus
    }
    
    private func possibleUpgrades(ids: [Int]) -> [[Int]] {
        var upgradeIndexes = [[Int]]()
        for upgradeCount in 0...ids.count {
            let combinations = allPossibleBeerUpgrades(beerIds: ids, numUpgrades: upgradeCount)
            upgradeIndexes.append(contentsOf: combinations)
        }
        return upgradeIndexes
    }
    
    private func generateMenu(beerCount: Int, upgradeIDs:[Int]) -> Menu {
        var beers = [Beer]()
        for beerId in 1...beerCount {
            var type = BrewType.classic
            if upgradeIDs.contains(beerId) {
                type = .barrelAged
            }
            beers.append(Beer(id: beerId, type:type))
        }
        return Menu(beers: beers)
    }
    
    private func idsOfBarrelPreferences(customerPreferences: [CustomerPreference]) -> [Int] {
        let allPreferences = customerPreferences.flatMap { $0.beers }
        let barrelPreferences = allPreferences.filter { $0.type == .barrelAged }
        let ids = barrelPreferences.map { $0.id }
        let unique = Array(Set(ids))
        return unique
    }
    
    private func menuSatisfiesCustomers(menu: Menu, customerPreferences:[CustomerPreference]) -> Bool {
        for customerPreference in customerPreferences {
            var foundCustomerSatisfaction = false
            for customerBeer in customerPreference.beers {
                if menu.beers.contains(customerBeer) {
                    foundCustomerSatisfaction = true
                }
            }
            if !foundCustomerSatisfaction {
                return false
            }
        }
        return true
    }
    
    private func allPossibleBeerUpgrades(beerIds: [Int], numUpgrades: Int) -> [[Int]] {
        guard beerIds.count >= 0 && numUpgrades > 0 else { return [[]] }
        if numUpgrades == 1 {
            return beerIds.map {[$0]}
        }
        var permutations = [[Int]]()
        for beerId in beerIds {
            permutations += allPossibleBeerUpgrades(beerIds: beerIds, numUpgrades: numUpgrades - 1).map {[beerId] + $0}
        }
        return permutations
    }
}
