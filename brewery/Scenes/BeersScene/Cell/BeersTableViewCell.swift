//
//  BeersTableViewCell.swift
//  brewery
//
//  Created by Raymond Dowe on 02/05/2021.
//

import UIKit

class BeersTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingDetailsSpinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingImageSpinner: UIActivityIndicatorView!
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

    override func prepareForReuse() {
        beerImageView.isHidden = true
        nameLabel.text = ""
        abvLabel.text = ""
        styleLabel.text = ""
    }
    
    func display(beerViewModel: Beers.LoadAvailableMenu.ViewModel.BeerViewModel) {
        if (beerViewModel.showDetailsSpinner) {
            if !loadingDetailsSpinner.isAnimating {
                loadingDetailsSpinner.startAnimating()
            }
        } else {
            loadingDetailsSpinner.stopAnimating()
            loadingDetailsSpinner.isHidden = true;
        }
        
        if (beerViewModel.showImageSpinner) {
            if !loadingImageSpinner.isAnimating {
                loadingImageSpinner.startAnimating()
            }
        } else {
            loadingImageSpinner.stopAnimating()
            loadingImageSpinner.isHidden = true;
        }
        
        if let beerImage = beerViewModel.image {
            beerImageView.isHidden = false
            beerImageView.image = beerImage
        }
        
        nameLabel.text = beerViewModel.name
        abvLabel.text = beerViewModel.abv
        styleLabel.text = beerViewModel.style
    }
    
}
