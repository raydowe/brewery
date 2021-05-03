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
    var sections: [BeerDetails.ShowBeerDetails.ViewModel.Section]?

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
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.name
            self.abvLabel.text = viewModel.abv
            self.descriptionTextView.text = viewModel.description
            self.sections = viewModel.sections
            self.tableView.reloadData()
        }
    }
}

extension BeerDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = sections?[section] else {
            return 0
        }
        return section.items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = sections?[section] else {
            return "?"
        }
        return section.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beerDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BeerDetailsTableViewCell", for: indexPath) as! BeerDetailsTableViewCell
        if let section = sections?[indexPath.section] {
            let textContent = section.items[indexPath.row]
            beerDetailsTableViewCell.contentLabel.text = textContent
        }
        return beerDetailsTableViewCell
    }
}
