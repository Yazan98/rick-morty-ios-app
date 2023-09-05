//
//  CharacterScreenViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 04/09/2023.
//

import UIKit

class CharacterScreenViewController: RmBaseVC {
    
    var id: Int64 = 0
    var name: String = ""
    
    public static func getInstance(id: Int64, name: String) -> CharacterScreenViewController {
        let vc = CharacterScreenViewController()
        vc.id = id
        vc.name = name
        return vc
    }
    
    override func onScreenStarted() {
        super.onScreenStarted()
    }

    override func getTitle() -> String {
        return name
    }

}
