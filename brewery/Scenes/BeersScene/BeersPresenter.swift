//
//  BeersPresenter.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BeersPresentationLogic {
    func presentAvailableMenu(response: Beers.LoadAvailableMenu.Response)
}

class BeersPresenter {
    
    var viewController: BeersDisplayLogic?
    
    private func makeViewModel(beersDetails: [Beers.LoadAvailableMenu.Response.BeerDetails]) -> [Beers.LoadAvailableMenu.ViewModel.BeerViewModel] {
        var beersViewModel = [Beers.LoadAvailableMenu.ViewModel.BeerViewModel]()
        
        let sortedBeerDetails = beersDetails.sorted(by: { $0.id < $1.id } )
        
        for beerDetails in sortedBeerDetails {
            if beerDetails.loadingData {
                let beerViewModel = Beers.LoadAvailableMenu.ViewModel.BeerViewModel(showDetailsSpinner: true, showImageSpinner: false,  image: nil, name: nil, abv: nil, style: nil)
                beersViewModel.append(beerViewModel)
                continue
            }
            
            var showImageSpinner = true
            var image:UIImage? = nil
            if let imageData = beerDetails.imageData {
                showImageSpinner = false
                image = UIImage(data: imageData)
            }
            
            let name = beerDetails.name
            var abv = "?"
            if let abvValue = beerDetails.abv {
                abv = "\(abvValue)% ABV"
            }
            var style = "Unknown"
            if let barrelAged = beerDetails.barrelAged {
                style = (barrelAged) ? "Barrel Aged" : "Classic"
            }
            let beerViewModel = Beers.LoadAvailableMenu.ViewModel.BeerViewModel(showDetailsSpinner: false, showImageSpinner: showImageSpinner, image: image, name: name, abv: abv, style: style)
            beersViewModel.append(beerViewModel)
        }
        
        return beersViewModel
    }
}

extension BeersPresenter: BeersPresentationLogic {

    func presentAvailableMenu(response: Beers.LoadAvailableMenu.Response) {
        let beerViewModels = makeViewModel(beersDetails: response.beersMenuDetails)
        let viewModel = Beers.LoadAvailableMenu.ViewModel(beerViewModels: beerViewModels)
        viewController?.displayAvailableMenu(viewModel: viewModel)
    }

}
