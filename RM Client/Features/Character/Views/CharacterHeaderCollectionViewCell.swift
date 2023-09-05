//
//  CharacterHeaderCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharacterHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deacriptionView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    
    public func configure(item: CharacterHeaderItem) {
        DispatchQueue.main.async { [weak self] in
          self?.imageView?.layer.cornerRadius = 5
          self?.imageView?.clipsToBounds = true
        }
        
        self.nameView.text = item.name
        self.deacriptionView.text = "This is the Long Text Desctiption Providing a Multi Lines in each Character Page info as you can see the Multiple Lines in Labels \(item.description)"
        
        guard let imageUrl = URL(string: item.image) else { return }
        imageView?.load(url: imageUrl)
    }
}
