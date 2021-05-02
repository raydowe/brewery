//
//  BeerImageDownloader.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import Foundation
import SwiftHTTP

protocol IBeerImageReceiver {
    func beerImageDataReceived(url: String, beerImageData: Data)
}

protocol IBeerImageDownloader {
    var receiver: IBeerImageReceiver? { get set }
    func download(url: String)
}

class BeerImageDownloader: IBeerImageDownloader {
    
    var receiver: IBeerImageReceiver?
    
    func download(url: String) {
        HTTP.GET(url) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            self.receiver?.beerImageDataReceived(url: url, beerImageData: response.data)
        }
    }
}
