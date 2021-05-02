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
    var beersViewModels = [Beers.LoadAvailableMenu.ViewModel.BeerViewModel]()
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BeersTableViewCell", bundle: nil), forCellReuseIdentifier: "BeersTableViewCell")
        self.loadMenu()
    }
    
    func loadMenu() {
        let request = Beers.LoadAvailableMenu.Request()
        self.interactor?.loadAvailableMenu(request: request)
    }
}

extension BeersViewController: BeersDisplayLogic {
    func displayAvailableMenu(viewModel: Beers.LoadAvailableMenu.ViewModel) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.beersViewModels = viewModel.beerViewModels
            self.tableView.reloadData()
        }
    }
}

extension BeersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beersViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beerViewModel = self.beersViewModels[indexPath.row]
        let beerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BeersTableViewCell", for: indexPath) as! BeersTableViewCell
        beerTableViewCell.display(beerViewModel: beerViewModel)
        return beerTableViewCell
    }
}

extension BeersViewController: UITableViewDelegate {
    
}
