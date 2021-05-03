//
//  BeerDetailsInteractor.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol BeerDetailsBusinessLogic {
    func loadBeerDetails(request: BeerDetails.ShowBeerDetails.Request)
}

class BeerDetailsInteractor {
    
    var presenter: BeerDetailsPresentationLogic?
    var router: BeerDetailsNavigation?
    
    var beerDetailsDownloader = BeerDetailsDownloader()
    var beerDetailsParser = BeerDetailsParser()
    
    init() {
        beerDetailsDownloader.receiver = self
    }
    
    func updateBeerDetails(beerDetailsJSON: String) {
        guard let beerDetailsJSON = beerDetailsParser.parse(beerDetailsJSON: beerDetailsJSON) else {
            return
        }
        let name = beerDetailsJSON.name
        let abv = beerDetailsJSON.abv
        let imageUrl = beerDetailsJSON.image_url
        let description = beerDetailsJSON.description
        let hops = beerDetailsJSON.ingredients.hops.map( { $0.name })
        
        //let malts = beerDetailsJSON.malts
        let malts = [String]()
        //let methods = beerDetailsJSON.methods
        let methods = [String]()
        
        let response = BeerDetails.ShowBeerDetails.Response(name: name, abv: abv, imageUrl: imageUrl, description: description, hops: hops, malts: malts, methods: methods)
        self.presenter?.presentBeerDetails(response: response)
    }
    
}

extension BeerDetailsInteractor: BeerDetailsBusinessLogic {
    
    func loadBeerDetails(request: BeerDetails.ShowBeerDetails.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.beerDetailsDownloader.download(id: request.id)
        }
        
        
        
        //let response = BeerDetails.ShowBeerDetails.Response(name: name, abv: abv, imageUrl: <#T##String#>, description: <#T##String#>, hops: <#T##[String]#>, malts: <#T##[String]#>, methods: <#T##[String]#>)
        //presenter?.presentAvailableMenu(response: response)
    }
}

extension BeerDetailsInteractor: IBeerDetailsReceiver {
    func beerDetailsReceived(beerDetailsJSON: String) {
        updateBeerDetails(beerDetailsJSON: beerDetailsJSON)
    }
}
