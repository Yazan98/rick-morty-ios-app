//
//  HomeScreenHeaderCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class HomeScreenHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleView?.text = "home_title".getLocalizedString()
        descriptionView?.text = "home_description".getLocalizedString()
    }

}
