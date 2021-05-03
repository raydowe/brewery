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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!

    var beerId: Int?

    convenience init() {
        self.init(beerId: nil)
    }

    init(beerId: Int?) {
        self.beerId = beerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BeerDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "BeerDetailsTableViewCell")
        if let beerId = self.beerId {
            loadBeerDetails(beerId: beerId)
        }
    }
    
    func loadBeerDetails(beerId: Int) {
        let request = BeerDetails.ShowBeerDetails.Request(id: beerId)
        self.interactor?.loadBeerDetails(request: request)
    }
}

extension BeerDetailsViewController: BeerDetailsDisplayLogic {
    func displayBeerDetails(viewModel: BeerDetails.ShowBeerDetails.ViewModel) {
        
    }
}

extension BeerDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let beerViewModel = self.beersViewModels[indexPath.row]
        let beerDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BeerDetailsTableViewCell", for: indexPath) as! BeerDetailsTableViewCell
        //beerDetailsTableViewCell.display(beerViewModel: beerViewModel)
        return beerDetailsTableViewCell
    }
    
    
}
