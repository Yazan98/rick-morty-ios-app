//
//  HomeNotificationsPermissionCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class HomeNotificationsPermissionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var acceptPermissionButton: UIButton!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        acceptPermissionButton?.setTitle("home_notifications_button".getLocalizedString(), for: .normal)
        titleView?.text = "home_notifications_title".getLocalizedString()
        descriptionView?.text = "home_notifications_des".getLocalizedString()
        
        acceptPermissionButton?.addTarget(self, action: #selector(onRequestNotificationsPermission), for: .touchUpInside)
    }
    
    @objc func onRequestNotificationsPermission() {
        RmPermissionsManager.shared.onRequestNotificationsPermission {
            Utils.onShowNotification(
                title: "Notifications Permission",
                body: "Now Rick and Morty can Submit Notifications"
            )
        }
    }

}
