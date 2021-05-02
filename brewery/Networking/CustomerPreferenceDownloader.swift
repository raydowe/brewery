//
//  File.swift
//  brewery
//
//  Created by Raymond Dowe on 27/04/2021.
//

import Foundation
import SwiftHTTP

protocol IPreferenceReceiver {
    func preferencesReceived(preferences: String)
}

protocol IPreferenceDownloader {
    var receiver: IPreferenceReceiver? { get set }
    func download(url: String)
}

class CustomerPreferenceDownloader: IPreferenceDownloader {
    
    var receiver: IPreferenceReceiver?
    
    func download(url: String) {
        HTTP.GET(url) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            guard let preferences = String(data: response.data, encoding: .utf8) else {
                return
            }
            self.receiver?.preferencesReceived(preferences: preferences)
        }
    }
}
