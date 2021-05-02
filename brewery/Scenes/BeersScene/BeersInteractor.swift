//
//  BeersInteractor.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeersBusinessLogic {
    func loadAvailableMenu(request: Beers.LoadAvailableMenu.Request)
}

class BeersInteractor {
    
    var presenter: BeersPresentationLogic?
    var router: BeersNavigation?
    var beersDetails = [Beers.LoadAvailableMenu.Response.BeerDetails]()
    
    func createMenu(preferences: String) {
        let parser = BeerRequestParser()
        let menuCreator = MenuCreator()
        guard let (beerCount, customerPreferences) = try? parser.parse(input: preferences),
              let menu = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences) else {
            // TODO: Menu not found display
            return
        }
        beersDetails = [Beers.LoadAvailableMenu.Response.BeerDetails]()
        for menuBeer in menu.beers {
            let beerDetails = Beers.LoadAvailableMenu.Response.BeerDetails(id: menuBeer.id, loading: true, imageData: nil, name: nil, abv: nil, barrelAged: false)
            loadBeerDetails(id: menuBeer.id)
            beersDetails.append(beerDetails)
        }
        let response = Beers.LoadAvailableMenu.Response(beersMenuDetails: beersDetails)
        self.presenter?.presentAvailableMenu(response: response)
    }
    
    func loadBeerDetails(id: Int) {
        
    }
}

extension BeersInteractor: BeersBusinessLogic {
    func loadAvailableMenu(request: Beers.LoadAvailableMenu.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            let customerPreferenceDownloader = CustomerPreferenceDownloader()
            customerPreferenceDownloader.receiver = self
            customerPreferenceDownloader.download(url: "https://gist.githubusercontent.com/LuigiPapinoDrop/d8ed153d5431bbad23e1e1c6b5ba1e3c/raw/4ec1c8064e51838240e941679d3ac063460685c2/code_challenge_richer.txt")
        }
    }
}

extension BeersInteractor: IPreferenceReceiver {
    func preferencesReceived(preferences: String) {
        self.createMenu(preferences: preferences)
    }
}
