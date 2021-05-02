//
//  BeerDetailsViewController.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import UIKit

protocol BeerDetailsDisplayLogic {
    func displayBeerDetails(viewModel: BeerDetails.ShowBeerDetails.ViewModel)
}

class BeerDetailsViewController: UIViewController {
    
    var interactor: BeerDetailsBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BeerDetailsViewController: BeerDetailsDisplayLogic {
    func displayBeerDetails(viewModel: BeerDetails.ShowBeerDetails.ViewModel) {
        // TODO: Something
    }
}
