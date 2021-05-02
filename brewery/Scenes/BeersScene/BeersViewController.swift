//
//  BeersViewController.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import UIKit

protocol BeersDisplayLogic {
    func displayAvailableMenu(viewModel: Beers.LoadAvailableMenu.ViewModel)
}

class BeersViewController: UIViewController {

    var interactor: BeersBusinessLogic?
    var ids = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMenu()
    }
    
    func loadMenu() {
        let request = Beers.LoadAvailableMenu.Request()
        self.interactor?.loadAvailableMenu(request: request)
    }

}

extension BeersViewController: BeersDisplayLogic {
    func displayAvailableMenu(viewModel: Beers.LoadAvailableMenu.ViewModel) {
        self.ids = viewModel.beerIds
    }
}


