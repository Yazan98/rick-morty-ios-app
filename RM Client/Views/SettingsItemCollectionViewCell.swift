//
//  SettingsItemCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class SettingsItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var cellContainerView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconView?.tintColor = .white
    }
    
    public func configure(item: RmSettingsItem) {
        self.cellContainerView?.backgroundColor = hexStringToUIColor(hex: item.backgroundColor)
        self.iconView?.image = UIImage(systemName: item.icon)
        self.titleView?.text = item.name
        self.descriptionView?.text = item.description
        DispatchQueue.main.async { [weak self] in
          self?.cellContainerView?.layer.cornerRadius = 10
          self?.cellContainerView?.clipsToBounds = true
        }
    }

}
