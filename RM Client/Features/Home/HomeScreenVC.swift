//
//  HomeScreenVC.swift
//  RM Client
//
//  Created by Yazan Tarifi on 31/08/2023.
//

import Foundation
import UIKit

public class HomeScreenVC: UITabBarController {
    
    public static func getInstance() -> HomeScreenVC {
        let vc = HomeScreenVC()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "home".getLocalizedString()
    }
}
