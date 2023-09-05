//
//  CharactersListScreenViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharactersListScreenViewController: RmBaseVC {
    
    public static func getInstance() -> CharactersListScreenViewController {
        return CharactersListScreenViewController()
    }

    override func onScreenStarted() {
        super.onScreenStarted()
    }
    
    override func getTitle() -> String {
        return "characters".getLocalizedString()
    }

}
