//
//  BeersTableViewCell.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import UIKit

class BeersTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func display(beerViewModel: Beers.LoadAvailableMenu.ViewModel.BeerViewModel) {
        if (beerViewModel.loading) {
            if !loadingSpinner.isAnimating {
                loadingSpinner.startAnimating()
            }
            beerImageView.isHidden = true
            nameLabel.text = ""
            abvLabel.text = ""
            styleLabel.text = ""
            return
        }
        
        loadingSpinner.stopAnimating()
        loadingSpinner.isHidden = true;
        
        beerImageView.image = beerViewModel.image
        nameLabel.text = beerViewModel.name
        abvLabel.text = beerViewModel.abv
        styleLabel.text = beerViewModel.style
    }
    
}
