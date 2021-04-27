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

    private var view: BeerDetailsView?

    static func assemble() -> BeerDetailsView {

        var view = BeerDetailsView()
        let presenter = BeerDetailsPresenter()
        let router = BeerDetailsRouter()
        let interactor = BeerDetailsInteractor()

        router.view = view
        interactor.router = router
        interactor.presenter = presenter
        view.interactor = interactor
        presenter.view = view

        return view
    }
}

extension BeerDetailsRouter: BeerDetailsNavigation {

    func navigateBack() {
    }

}
