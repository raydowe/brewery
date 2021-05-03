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
        let abv = "\(response.name)% ABV"
        let imageUrl = response.imageUrl
        let description = response.description
        let hopsSection = BeerDetails.ShowBeerDetails.ViewModel.Section(title: "Hops", items: response.hops)
        let maltSection = BeerDetails.ShowBeerDetails.ViewModel.Section(title: "Malts", items: response.malts)
        let methodsSection = BeerDetails.ShowBeerDetails.ViewModel.Section(title: "Methods", items: response.methods)
        let sections = [hopsSection, maltSection, methodsSection]
        let viewModel = BeerDetails.ShowBeerDetails.ViewModel(name: name, abv: abv, imageUrl: imageUrl, description: description, sections: sections)
        viewController?.displayBeerDetails(viewModel: viewModel)
    }

}
