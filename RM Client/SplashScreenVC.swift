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

        // Init Splash Design
        view.backgroundColor = RmThemeUtils.shared.getApplicationPrimaryColor()
        let configuration = UIImage.SymbolConfiguration(textStyle: .footnote, scale: .small)
        let image = UIImage(systemName: "person.circle.fill", withConfiguration: configuration)

        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(imageView)
        
        // Add Logo Constraints
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80).isActive = true
        
        // Start The Timer to Load Splash Screen Time
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.onValidateApplicationNavigation()
        })
    }
    
    private func onValidateApplicationNavigation() {
        if RmLocalStorage.shared.isFirstTimeAppOpened() {
            self.navigationController?.pushViewController(OnBoardingScreenVC.getInstance(), animated: true)
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
