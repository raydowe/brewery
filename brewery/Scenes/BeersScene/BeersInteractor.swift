//
//  BeersInteractor.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeersBusinessLogic {
    func loadAvailableBeers(request: Beers.LoadAvailableMenu.Request)
}

class BeersInteractor {
    var presenter: BeersPresentationLogic?
    var router: BeersNavigation?
}

extension BeersInteractor: BeersBusinessLogic {
    func loadAvailableBeers(request: Beers.LoadAvailableMenu.Request) {
        let response = Beers.LoadAvailableMenu.Response()
        presenter?.presentAvailableMenu(response: response)
    }
}
