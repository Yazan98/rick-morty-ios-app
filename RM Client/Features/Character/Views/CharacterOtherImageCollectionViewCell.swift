//
//  CharacterOtherImageCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharacterOtherImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleView: UILabel!
    public func onLoadImage(item: CharacterOtherInfoItem) {
        self.imageView?.image = nil;
        self.titleView?.text = item.name
        
        DispatchQueue.main.async { [weak self] in
          self?.imageView?.layer.cornerRadius = 5
          self?.imageView?.clipsToBounds = true
        }
        
        guard let imageUrl = URL(string: item.image) else { return }
        imageView?.load(url: imageUrl)
    }

}
