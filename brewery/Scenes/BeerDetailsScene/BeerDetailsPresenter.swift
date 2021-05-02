//
//  BeerDetailsPresenter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeerDetailsPresentationLogic {
    func presentAvailableMenu(response: BeerDetails.ShowBeerDetails.Response)
}

class BeerDetailsPresenter {
    var viewController: BeerDetailsDisplayLogic?
}

extension BeerDetailsPresenter: BeerDetailsPresentationLogic {
    func presentAvailableMenu(response: BeerDetails.ShowBeerDetails.Response) {
        let viewModel = BeerDetails.ShowBeerDetails.ViewModel()
        viewController?.displayBeerDetails(viewModel: viewModel)
    }

}
