//
//  BeerDetailsDownloader.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import Foundation
import SwiftHTTP

protocol IBeerDetailsReceiver {
    func beerDetailsReceived(beerDetailsJSON: String)
}

protocol IBeerDetailsDownloader {
    var receiver: IBeerDetailsReceiver? { get set }
    func download(id: Int)
}

class BeerDetailsDownloader: IBeerDetailsDownloader {
    
    var receiver: IBeerDetailsReceiver?
    
    func download(id: Int) {
        let url = "https://api.punkapi.com/v2/beers/\(id)"
        HTTP.GET(url) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            guard let beerDetailsJSON = String(data: response.data, encoding: .utf8) else {
                return
            }
            self.receiver?.beerDetailsReceived(beerDetailsJSON: beerDetailsJSON)
        }
    }
}
