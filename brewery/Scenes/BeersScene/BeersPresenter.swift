//
//  BeersPresenter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeersPresentationLogic {
    func presentAvailableMenu(response: Beers.LoadAvailableMenu.Response)
}

class BeersPresenter {
    var view: BeersDisplayLogic?
}

extension BeersPresenter: BeersPresentationLogic {

    func presentAvailableMenu(response: Beers.LoadAvailableMenu.Response) {
        let beerIds = response.menu.beers.map{ String($0.id) }
        let viewModel = Beers.LoadAvailableMenu.ViewModel(beerIds: beerIds)
        view?.displayAvailableBeers(viewModel: viewModel)
    }

}
