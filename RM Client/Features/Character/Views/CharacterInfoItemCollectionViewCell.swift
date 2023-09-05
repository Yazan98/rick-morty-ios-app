//
//  CharacterInfoItemCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharacterInfoItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var valueView: UILabel!
    
    public func configure(item: CharacterItemInfo) {
        self.titleView.text = item.name
        self.valueView.text = item.value
    }

}
