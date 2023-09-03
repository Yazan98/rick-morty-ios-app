//
//  CharacterHorizantelCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class CharacterHorizantelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentViewCell.clipsToBounds = false
//        contentViewCell.layer.cornerRadius = 15
//        contentViewCell.backgroundColor = UIColor.white
//        self.backgroundColor = UIColor(red: 247.0/255, green: 247.0/255, blue: 247.0/255, alpha: 1.0)
    }
    
    public func configure(item: RmCharacterModel) {
        nameView?.text = item.name ?? ""
        descriptionView?.text = "\(item.species ?? "") - \(item.status ?? "")"
        
        characterImageView?.backgroundColor = .red
        characterImageView?.layer.masksToBounds = true
        
        DispatchQueue.main.async { [weak self] in
          self?.characterImageView?.layer.cornerRadius = 5
          self?.characterImageView?.clipsToBounds = true
        }
        
        guard let imageUrl = URL(string: item.image ?? "") else { return }
        characterImageView?.load(url: imageUrl)
    }

}
