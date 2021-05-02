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
        for beerDetails in beersDetails {
            if beerDetails.loading {
                let beerViewModel = Beers.LoadAvailableMenu.ViewModel.BeerViewModel(loading: true, image: nil, name: nil, abv: nil, style: nil)
                beersViewModel.append(beerViewModel)
                continue
            }
            
            var image:UIImage? = nil
            if let imageData = beerDetails.imageData {
                image = UIImage(data: imageData)
            }
            
            let name = beerDetails.name
            var abv = "?"
            if let abvValue = beerDetails.abv {
                abv = "\(abvValue)%"
            }
            var style = "Unknown"
            if let barrelAged = beerDetails.barrelAged {
                style = (barrelAged) ? "Barrel Aged" : "Classic"
            }
            let beerViewModel = Beers.LoadAvailableMenu.ViewModel.BeerViewModel(loading: false, image: image, name: name, abv: abv, style: style)
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
