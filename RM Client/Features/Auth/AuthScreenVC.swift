//
//  AuthScreenVC.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class AuthScreenVC: RmBaseVC {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var loginByEmailButton: UIButton!
    @IBOutlet weak var loginByAppleButton: UIButton!
    
    public static func getInstance() -> AuthScreenVC {
        return AuthScreenVC()
    }

    override func onScreenStarted() {
        super.onScreenStarted()
        

    }
    
    override func setupViewsContent() {
        super.setupViewsContent()
        loginByAppleButton?.setTitle("login_by_apple".getLocalizedString(), for: .normal)
        skipButton?.setTitle("skip".getLocalizedString(), for: .normal)
        loginByEmailButton?.setTitle("login_by_email".getLocalizedString(), for: .normal)
        
        emailAddressField?.placeholder = "login_hint_email".getLocalizedString()
        passwordTextField?.placeholder = "login_hint_password".getLocalizedString()
    }
    
    @IBAction func onLoginByEmailClickListener(_ sender: Any) {
        if emailAddressField.text?.isEmpty == true {
            Utils.showMessage(errorMessage: "email_address_required".getLocalizedString())
        }
        
        if passwordTextField.text?.isEmpty == true {
            Utils.showMessage(errorMessage: "password_required".getLocalizedString())
        }
    }
    
    @IBAction func onAppleLoginClickListener(_ sender: Any) {
        
    }
    
    @IBAction func onSkipButtonClicked(_ sender: Any) {
        RmLocalStorage.shared.onUpdateUserLoggedInStatus(newStatus: true)
        onPushPresentStackView(vc: HomeScreenVC.getInstance())
    }
    
    override func getTitle() -> String {
        return "login".getLocalizedString()
    }
    
}
