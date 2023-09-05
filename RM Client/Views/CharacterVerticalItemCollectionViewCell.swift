//
//  CharacterVerticalItemCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharacterVerticalItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    public func configure(item: RmCharacterModel?) {
        descriptionView?.text = "\(item?.species ?? "") - \(item?.gender ?? "") - \(item?.status ?? "")"
        titleView?.text = item?.name ?? ""
        self.imageView?.image = nil;

        DispatchQueue.main.async { [weak self] in
          self?.imageView?.layer.cornerRadius = 5
          self?.imageView?.clipsToBounds = true
        }
        
        
        guard let imageUrl = URL(string: item?.image ?? "") else { return }
        imageView?.load(url: imageUrl)
    }

}
