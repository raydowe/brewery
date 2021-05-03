//
//  BeerDetailsModels.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum BeerDetails {

    enum ShowBeerDetails {

        struct Request {
            let id: Int
        }

        struct Response {
            
            struct Hop {
                let name: String
                let amount: Amount
                let add: String
                let attribute: String
            }
            
            struct Malt {
                let name: String
                let amount: Amount
            }
            
            struct Amount {
                let value: Float
                let unit: String
            }
            
            struct MashTemp {
                let temp: Temp
                let duration: Int?
            }
            
            struct Fermentation {
                let temp: Temp
            }
            
            struct Temp {
                let value: Int
                let unit: String
            }
            
            let name: String
            let abv: Float
            let imageUrl: String
            let description: String
            let hops: [Hop]
            let malts: [Malt]
            
            let mashTemps: [MashTemp]
            let fermentation: Fermentation
            let twist: String?
        }

        struct ViewModel {
            
            struct Section {
                let title: String
                let items: [String]
            }
            
            let name: String
            let abv: String
            let imageUrl: String
            let description: String
            let sections: [Section]
        }
    }
}
