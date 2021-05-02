//
//  BeersModels.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Beers {

    enum LoadAvailableMenu {

        struct Request {
        }

        struct Response {
            
            struct BeerDetails {
                let id: Int
                let loading: Bool
                let imageData: Data?
                let name: String?
                let abv: Float?
                let barrelAged: Bool?
            }
            
            var beersMenuDetails: [BeerDetails]
        }

        struct ViewModel {
            
            struct BeerViewModel {
                let loading: Bool
                let image: UIImage?
                let name: String?
                let abv: String?
                let style: String?
            }

            var beerViewModels: [BeerViewModel]
        }
    }
}
