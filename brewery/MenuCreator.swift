//
//  BrewsCreator.swift
//  brewery
//
//  Created by Raymond Dowe on 19/04/2021.
//

import Foundation

internal protocol IMenuCreator {
    func generateMenu(beerCount: Int, customerPreferences:[CustomerPreference]) -> [Beer]
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
    
    func generateMenu(beerCount: Int, customerPreferences:[CustomerPreference]) -> [Beer] {
        return [Beer]()
    }
}
