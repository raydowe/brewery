//
//  BeerDetailsRouter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol BeerDetailsNavigation {
    func navigateBack()
}

class BeerDetailsRouter {

    private var viewController: BeerDetailsDisplayLogic?

    static func assemble(beerId: Int) -> BeerDetailsDisplayLogic {

        let viewController = BeerDetailsViewController(beerId: beerId)
        let presenter = BeerDetailsPresenter()
        let router = BeerDetailsRouter()
        let interactor = BeerDetailsInteractor()

        router.viewController = viewController
        interactor.router = router
        interactor.presenter = presenter
        viewController.interactor = interactor
        presenter.viewController = viewController

        return viewController
    }
}

extension BeerDetailsRouter: BeerDetailsNavigation {

    func navigateBack() {
    }

}
