//
//  BeersViewController.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol BeersDisplayLogic {
    func displayAvailableBeers(viewModel: Beers.LoadAvailableMenu.ViewModel)
}

struct BeersView: View {

    var interactor: BeersBusinessLogic?

    var body: some View {
        Text("Hello, Beer!")
            .padding()
    }
}

struct BeersView_Previews: PreviewProvider {
    static var previews: some View {
        BeersView()
    }
}

extension BeersView: BeersDisplayLogic {
    func displayAvailableBeers(viewModel: Beers.LoadAvailableMenu.ViewModel) {
    }
}
