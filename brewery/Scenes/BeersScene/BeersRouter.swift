//
//  BeersRouter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol BeersNavigation {
    func navigateToBeer()
}

class BeersRouter {

    private var view: BeersView?

    static func assemble() -> BeersView {

        var view = BeersView()
        let presenter = BeersPresenter()
        let router = BeersRouter()
        let interactor = BeersInteractor()

        router.view = view
        interactor.router = router
        interactor.presenter = presenter
        view.interactor = interactor
        presenter.view = view

        return view
    }
}

extension BeersRouter: BeersNavigation {

    // MARK: navigation logic methods
    func navigateToBeer() {
        //let beerViewController = BeersRouter.assemble()
        //self.view?.present(beerViewController, animated: true, completion: nil)
    }

}
