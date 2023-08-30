//
//  ViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 31/08/2023.
//

import UIKit

class SplashScreenVC: RmBaseVC {

    override func onScreenStarted() {
        super.onScreenStarted()

        view.backgroundColor = RmThemeUtils.shared.getApplicationPrimaryColor()
        let configuration = UIImage.SymbolConfiguration(textStyle: .footnote, scale: .small)
        let image = UIImage(systemName: "person.circle.fill", withConfiguration: configuration)

        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(imageView)
        onCenterViewConstraints(targetView: imageView)
        
        
        // Start The Timer to Load Splash Screen Time
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.onValidateApplicationNavigation()
        })
    }
    
    private func onValidateApplicationNavigation() {
        if RmLocalStorage.shared.isFirstTimeAppOpened() {
            onPushViewController(vc: OnBoardingScreenVC.getInstance())
            return
        }
        
        if RmLocalStorage.shared.isUserLoggedIn() {
            onPushViewController(vc: HomeScreenVC.getInstance())
            return
        }
        
        onPushViewController(vc: AuthScreenVC.getInstance())
    }
    
    override func getTitle() -> String {
        return "Splash"
    }

}
