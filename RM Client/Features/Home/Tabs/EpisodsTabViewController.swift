//
//  EpisodsTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class EpisodsTabViewController: RmBaseVC {
    
    public static func getInstance() -> EpisodsTabViewController {
        return EpisodsTabViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func getTitle() -> String {
        return "episods".getLocalizedString()
    }

}
