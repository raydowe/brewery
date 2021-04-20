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
        let indexesOfUpgrades = indexesOfBarrelPreferences(customerPreferences: customerPreferences)
        let menusToTry = generateMenus(beerCount: beerCount, indexesOfUpgrades: indexesOfUpgrades)
        for menuToTry in menusToTry {
            if menuSatisfiesCustomers(menu: menuToTry, customerPreferences: customerPreferences) {
                return menuToTry
            }
        }
        return nil
    }
    
    private func generateMenus(beerCount: Int, indexesOfUpgrades: [Int]) -> [Menu] {
        var menus = [Menu]()
        let allPossibleUpgrades = possibleUpgrades(indexes: indexesOfUpgrades)
        for possibleUpgrades in allPossibleUpgrades {
            let menuWithUpgrades = generateMenu(beerCount: beerCount, upgradeIndexes: possibleUpgrades)
            menus.append(menuWithUpgrades)
        }
        return menus
    }
    
    private func possibleUpgrades(indexes: [Int]) -> [[Int]] {
        var allPossibleUpgrades = [[Int]]()
        let empty = [Int]()
        allPossibleUpgrades.append(empty)
        let allCombinations = addAllCombinations(existing: indexes, possibleAdditions: indexes)
        allPossibleUpgrades.append(contentsOf: allCombinations)
        return allPossibleUpgrades
    }
    
    private func addAllCombinations(existing:[Int], possibleAdditions:[Int]) -> [[Int]] {
        
    }
    
    private func generateMenu(beerCount: Int, upgradeIndexes:[Int]) -> Menu {
        var beers = [Beer]()
        for index in 1...beerCount {
            var type = BrewType.classic
            if upgradeIndexes.contains(index - 1) {
                type = .barrelAged
            }
            beers.append(Beer(id: index, type:type))
        }
        return Menu(beers: beers)
    }
    
    private func indexesOfBarrelPreferences(customerPreferences: [CustomerPreference]) -> [Int] {
        let allPreferences = customerPreferences.flatMap { $0.beers }
        let barrelPreferences = allPreferences.filter { $0.type == .barrelAged }
        let indexes = barrelPreferences.map { $0.id }
        let unique = Array(Set(indexes))
        return unique
    }
    
    private func menuSatisfiesCustomers(menu: Menu, customerPreferences:[CustomerPreference]) -> Bool {
        for customerPreference in customerPreferences {
            for customerBeer in customerPreference.beers {
                if menu.beers.contains(customerBeer) {
                    break
                }
                return false
            }
        }
        return true
    }
}
