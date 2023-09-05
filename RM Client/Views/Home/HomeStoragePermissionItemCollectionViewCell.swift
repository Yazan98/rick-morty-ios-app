//
//  HomeStoragePermissionItemCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class HomeStoragePermissionItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button?.setTitle("permission_button".getLocalizedString(), for: .normal)
        title?.text = "storage_permission".getLocalizedString()
        hint?.text = "storage_permission_hint".getLocalizedString()
        
        button?.addTarget(self, action: #selector(onRequestStoragePermission), for: .touchUpInside)
    }

    @objc func onRequestStoragePermission() {
        RmPermissionsManager.shared.onRequestGalleryAccess {
            Utils.onShowNotification(
                title: "Gallery Permission",
                body: "Now Rick and Morty can Access Local Storage ..."
            )
        }
    }
    
}
