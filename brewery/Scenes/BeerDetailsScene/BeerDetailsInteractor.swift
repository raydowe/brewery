//
//  BeerDetailsInteractor.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeerDetailsBusinessLogic {
    func loadBeerDetails(request: BeerDetails.ShowBeerDetails.Request)
}

class BeerDetailsInteractor {
    var presenter: BeerDetailsPresentationLogic?
    var router: BeerDetailsNavigation?
}

extension BeerDetailsInteractor: BeerDetailsBusinessLogic {
    func loadBeerDetails(request: BeerDetails.ShowBeerDetails.Request) {
        let response = BeerDetails.ShowBeerDetails.Response()
        presenter?.presentAvailableMenu(response: response)
    }
}
