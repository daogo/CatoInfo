//
//  CatBreedTableViewCell.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 27/10/2020.
//

import UIKit


class CatBreedTableViewCell: UITableViewCell {

    var viewModel : CatBreedTableViewCellViewModel? {
        didSet {
            self.nameLabel.text = viewModel?.displayName ?? "No Name"
            self.descriptionLabel.text = viewModel?.shortBreedDescription ?? ""
        }
        
    }
    
    @IBOutlet weak var catImageView: UIImageView! {
        didSet {
            let image = UIImage(named: "cat")?.withTintColor(Colors.mainTextColor)
            catImageView.image = image
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}

