//
//  BeersRouter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol BeersNavigation {
    func navigateToBeer(id: Int)
}

class BeersRouter {

    private var viewController: BeersDisplayLogic?

    static func assemble() -> BeersDisplayLogic {

        let viewController = BeersViewController()
        let presenter = BeersPresenter()
        let router = BeersRouter()
        let interactor = BeersInteractor()

        router.viewController = viewController
        interactor.router = router
        interactor.presenter = presenter
        viewController.interactor = interactor
        presenter.viewController = viewController

        return viewController
    }
}

extension BeersRouter: BeersNavigation {

    // MARK: navigation logic methods
    func navigateToBeer(id: Int) {
        guard let beerDetailsViewController = BeerDetailsRouter.assemble() as? UIViewController,
              let beersViewController = self.viewController as? UIViewController else {
            return
        }
        beersViewController.navigationController?.pushViewController(beerDetailsViewController, animated: true)
    }

}
