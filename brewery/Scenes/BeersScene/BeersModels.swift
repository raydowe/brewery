//
//  BeersModels.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum Beers {

    enum LoadAvailableMenu {

        struct Request {
        }

        struct Response {
            var menu: Menu
        }

        struct ViewModel {
            var beerIds: [String]
        }
    }
}
