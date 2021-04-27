//
//  BeerDetailsViewController.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol BeerDetailsDisplayLogic {
    func displayBeerDetails(viewModel: BeerDetails.ShowBeerDetails.ViewModel)
}

struct BeerDetailsView: View {

    var interactor: BeerDetailsBusinessLogic?

    init() {
        self.loadBeerDetails()
    }
    
    var body: some View {
        Text("Hello, Beer!")
            .padding()
    }
    
    private func loadBeerDetails() {
        let request = BeerDetails.ShowBeerDetails.Request()
        interactor?.loadBeerDetails(request: request)
    }
}

struct BeerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BeersView()
    }
}

extension BeerDetailsView: BeerDetailsDisplayLogic {
    func displayBeerDetails(viewModel: BeerDetails.ShowBeerDetails.ViewModel) {
    }
}
