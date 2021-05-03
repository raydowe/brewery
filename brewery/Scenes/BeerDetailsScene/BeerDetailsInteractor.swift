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
    func loadImage(request: BeerDetails.LoadImage.Request)
}

class BeerDetailsInteractor {
    
    var presenter: BeerDetailsPresentationLogic?
    var router: BeerDetailsNavigation?
    
    var beerDetailsDownloader = BeerDetailsDownloader()
    var beerImageDownloader = BeerImageDownloader()
    var beerDetailsParser = BeerDetailsParser()
    
    init() {
        beerDetailsDownloader.receiver = self
        beerImageDownloader.receiver = self
    }
    
    private func updateBeerDetails(beerDetailsJSON: String) {
        guard let beerDetailsJSON = beerDetailsParser.parse(beerDetailsJSON: beerDetailsJSON) else {
            return
        }
        let name = beerDetailsJSON.name
        let abv = beerDetailsJSON.abv
        let imageUrl = beerDetailsJSON.image_url
        let description = beerDetailsJSON.description
        let hops = hopsForJSON(beerDetailsJSON.ingredients.hops)
        let malts = maltsForJSON(beerDetailsJSON.ingredients.malt)
        let mashTemps = mashTempsForJSON(beerDetailsJSON.method.mash_temp)
        let fermentation = BeerDetails.ShowBeerDetails.Response.Fermentation(temp: BeerDetails.ShowBeerDetails.Response.Temp(value: beerDetailsJSON.method.fermentation.temp.value, unit: beerDetailsJSON.method.fermentation.temp.unit))
        let twist = beerDetailsJSON.method.twist
        let response = BeerDetails.ShowBeerDetails.Response(name: name, abv: abv, imageUrl: imageUrl, description: description, hops: hops, malts: malts, mashTemps: mashTemps, fermentation: fermentation, twist: twist)
        self.presenter?.presentBeerDetails(response: response)
    }
    
    
    private func updateImage(beerImageData: Data) {
        let response = BeerDetails.LoadImage.Response(imageData: beerImageData)
        self.presenter?.presentImage(response: response)
    }
    
    private func hopsForJSON(_ hopsJSON: [HopJSON]) -> [BeerDetails.ShowBeerDetails.Response.Hop] {
        var hops = [BeerDetails.ShowBeerDetails.Response.Hop]()
        for hopJSON in hopsJSON {
            let name = hopJSON.name
            let amount = amountForJSON(hopJSON.amount)
            let add = hopJSON.add
            let attribute = hopJSON.attribute
            let hop = BeerDetails.ShowBeerDetails.Response.Hop(name: name, amount: amount, add: add, attribute: attribute)
            hops.append(hop)
        }
        return hops
    }
    
    private func maltsForJSON(_ maltsJSON: [MaltJSON]) -> [BeerDetails.ShowBeerDetails.Response.Malt] {
        var malts = [BeerDetails.ShowBeerDetails.Response.Malt]()
        for maltJSON in maltsJSON {
            let amount = amountForJSON(maltJSON.amount)
            let malt = BeerDetails.ShowBeerDetails.Response.Malt(name: maltJSON.name, amount: amount)
            malts.append(malt)
        }
        return malts
    }
    
    private func amountForJSON(_ amountJSON: AmountJSON) -> BeerDetails.ShowBeerDetails.Response.Amount {
        let amount = BeerDetails.ShowBeerDetails.Response.Amount(value: amountJSON.value, unit: amountJSON.unit)
        return amount
    }
    
    private func mashTempsForJSON(_ mashTempsJSON: [MashTempJSON]) -> [BeerDetails.ShowBeerDetails.Response.MashTemp] {
        var mashTemps = [BeerDetails.ShowBeerDetails.Response.MashTemp]()
        for mashTempJSON in mashTempsJSON {
            let temp = BeerDetails.ShowBeerDetails.Response.Temp(value: mashTempJSON.temp.value, unit: mashTempJSON.temp.unit)
            let mashTemp = BeerDetails.ShowBeerDetails.Response.MashTemp(temp: temp, duration: mashTempJSON.duration)
            mashTemps.append(mashTemp)
        }
        return mashTemps
    }
}

extension BeerDetailsInteractor: BeerDetailsBusinessLogic {
    
    func loadBeerDetails(request: BeerDetails.ShowBeerDetails.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.beerDetailsDownloader.download(id: request.id)
        }
    }
    
    func loadImage(request: BeerDetails.LoadImage.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.beerImageDownloader.download(url: request.url)
        }
    }
}

extension BeerDetailsInteractor: IBeerDetailsReceiver {
    func beerDetailsReceived(beerDetailsJSON: String) {
        updateBeerDetails(beerDetailsJSON: beerDetailsJSON)
    }
}

extension BeerDetailsInteractor: IBeerImageReceiver {
    func beerImageDataReceived(url: String, beerImageData: Data) {
        updateImage(beerImageData: beerImageData)
    }
}
