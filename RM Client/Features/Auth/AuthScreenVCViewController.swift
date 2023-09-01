//
//  AuthScreenVCViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class AuthScreenVC: RmBaseVC {

    public static func getInstance() -> AuthScreenVC {
        return AuthScreenVC()
    }

    override func onScreenStarted() {
        super.onScreenStarted()
        let text = UITextView()
        text.text = "Auth"
        
        view?.addSubview(text)
    }
    
    override func getTitle() -> String {
        return "login".getLocalizedString()
    }

}
