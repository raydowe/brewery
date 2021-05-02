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
    private var ids:[String] = [String]()

    private func loadMenu() {
        let request = Beers.LoadAvailableMenu.Request()
        self.interactor?.loadAvailableMenu(request: request)
    }
    
    var body: some View {
        List(ids, id: \.self) { id in
                        Text(id)
                    }//.font(.largeTitle)
        
        /*Text("Test Menu...")
            .padding()
            .onAppear(perform: {
                self.loadMenu()
            })*/
    }
}

struct BeersView_Previews: PreviewProvider {
    static var previews: some View {
        BeersView()
    }
}

extension BeersView: BeersDisplayLogic {
    func displayAvailableBeers(viewModel: Beers.LoadAvailableMenu.ViewModel) {
        ids = viewModel.beerIds
    }
}
