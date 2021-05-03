//
//  BeerDetailsPresenter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeerDetailsPresentationLogic {
    func presentBeerDetails(response: BeerDetails.ShowBeerDetails.Response)
}

class BeerDetailsPresenter {
    var viewController: BeerDetailsDisplayLogic?
}

extension BeerDetailsPresenter: BeerDetailsPresentationLogic {
    
    func presentBeerDetails(response: BeerDetails.ShowBeerDetails.Response) {
        let name = response.name
        let abv = "\(response.abv)% ABV"
        let imageUrl = response.imageUrl
        let description = response.description
        let hops = hopsStrings(response.hops)
        let hopsSection = BeerDetails.ShowBeerDetails.ViewModel.Section(title: "Hops", items: hops)
        let malts = maltsStrings(response.malts)
        let maltSection = BeerDetails.ShowBeerDetails.ViewModel.Section(title: "Malts", items: malts)
        let methods = methodStrings(mashTemps: response.mashTemps, fermentation: response.fermentation, twist: response.twist)
        let methodsSection = BeerDetails.ShowBeerDetails.ViewModel.Section(title: "Methods", items: methods)
        let sections = [hopsSection, maltSection, methodsSection]
        let viewModel = BeerDetails.ShowBeerDetails.ViewModel(name: name, abv: abv, imageUrl: imageUrl, description: description, sections: sections)
        viewController?.displayBeerDetails(viewModel: viewModel)
    }
    
    func hopsStrings(_ hops: [BeerDetails.ShowBeerDetails.Response.Hop]) -> [String] {
        let strings = hops.map { hop -> String in
            return "\(hop.name), \(hop.amount.value) \(hop.amount.unit) at the \(hop.add) for \(hop.attribute)"
        }
        return strings
    }
    
    func maltsStrings(_ malts: [BeerDetails.ShowBeerDetails.Response.Malt]) -> [String] {
        let strings = malts.map { malt -> String in
            return "\(malt.name), \(malt.amount.value) \(malt.amount.unit)"
        }
        return strings
    }
    
    func methodStrings(mashTemps: [BeerDetails.ShowBeerDetails.Response.MashTemp], fermentation: BeerDetails.ShowBeerDetails.Response.Fermentation, twist: String?) -> [String] {
        var strings = [String]()
        
        let mashTempStrings = mashTemps.map { mashTemp -> String in
            var durationString = "until ready"
            if let duration = mashTemp.duration {
                durationString = "for \(duration) minutes"
            }
            return "Mash at \(mashTemp.temp.value) \(mashTemp.temp.unit) \(durationString)"
        }
        strings.append(contentsOf: mashTempStrings)
        
        let fermentationString = "Ferment at \(fermentation.temp.value) \(fermentation.temp.unit)"
        strings.append(fermentationString)
        
        if let twist = twist {
            strings.append(twist)
        }
        
        return strings
    }

}
