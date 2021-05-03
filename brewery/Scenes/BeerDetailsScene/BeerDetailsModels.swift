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
            let name: String
            let abv: Float
            let imageUrl: String
            let description: String
            let hops: [String]
            let malts: [String]
            let methods: [String]
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
