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
    var beerDetailsDownloader = BeerDetailsDownloader()
    var beerDetailsParser = BeerDetailsParser()
    var beerImageDownloader = BeerImageDownloader()
    let queue = DispatchQueue(label: "ThreadSafeCollection.queue", attributes: .concurrent)
    
    func createMenu(preferences: String) {
    
        beerDetailsDownloader.receiver = self
        beerImageDownloader.receiver = self
        
        let parser = BeerRequestParser()
        let menuCreator = MenuCreator()
        guard let (beerCount, customerPreferences) = try? parser.parse(input: preferences),
              let menu = menuCreator.generateMenu(beerCount: beerCount, customerPreferences: customerPreferences) else {
            return
        }
        beersDetails = [Beers.LoadAvailableMenu.Response.BeerDetails]()
        for menuBeer in menu.beers {
            let beerDetails = Beers.LoadAvailableMenu.Response.BeerDetails(id: menuBeer.id, loadingData: true, imageUrl: nil, imageData: nil, name: nil, abv: nil, barrelAged: menuBeer.type == .barrelAged)
            beerDetailsDownloader.download(id: menuBeer.id)
            beersDetails.append(beerDetails)
        }
        let response = Beers.LoadAvailableMenu.Response(beersMenuDetails: beersDetails)
        self.presenter?.presentAvailableMenu(response: response)
    }
    
    func updateBeerDetails(beerDetailsJSON: String) {
        guard let beerDetailsJSON = beerDetailsParser.parse(beerDetailsJSON: beerDetailsJSON) else {
            return
        }
        var updatedBeersDetails = [Beers.LoadAvailableMenu.Response.BeerDetails]()
        for beerDetails in self.beersDetails {
            if beerDetails.id == beerDetailsJSON.id {
                let updatedBeerDetails = Beers.LoadAvailableMenu.Response.BeerDetails(id: beerDetailsJSON.id, loadingData: false, imageUrl:beerDetailsJSON.image_url, imageData: nil, name: beerDetailsJSON.name, abv: beerDetailsJSON.abv, barrelAged: beerDetails.barrelAged)
                updatedBeersDetails.append(updatedBeerDetails)
                beerImageDownloader.download(url: beerDetailsJSON.image_url)
            } else {
                updatedBeersDetails.append(beerDetails)
            }
        }
        self.beersDetails = updatedBeersDetails
        let response = Beers.LoadAvailableMenu.Response(beersMenuDetails: updatedBeersDetails)
        self.presenter?.presentAvailableMenu(response: response)
    }
    
    func updateImage(url: String, beerImageData: Data) {
        var updatedBeersDetails = [Beers.LoadAvailableMenu.Response.BeerDetails]()
        for beerDetails in self.beersDetails {
            if beerDetails.imageUrl == url {
                let updatedBeerDetails = Beers.LoadAvailableMenu.Response.BeerDetails(id: beerDetails.id, loadingData: false, imageUrl: beerDetails.imageUrl, imageData: beerImageData, name: beerDetails.name, abv: beerDetails.abv, barrelAged: beerDetails.barrelAged)
                updatedBeersDetails.append(updatedBeerDetails)
            } else {
                updatedBeersDetails.append(beerDetails)
            }
        }
        self.beersDetails = updatedBeersDetails
        let response = Beers.LoadAvailableMenu.Response(beersMenuDetails: updatedBeersDetails)
        self.presenter?.presentAvailableMenu(response: response)
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

extension BeersInteractor: IBeerDetailsReceiver {
    func beerDetailsReceived(beerDetailsJSON: String) {
        self.updateBeerDetails(beerDetailsJSON: beerDetailsJSON)
    }
}

extension BeersInteractor: IBeerImageReceiver {
    func beerImageDataReceived(url: String, beerImageData: Data) {
        self.updateImage(url: url, beerImageData: beerImageData)
    }
}
