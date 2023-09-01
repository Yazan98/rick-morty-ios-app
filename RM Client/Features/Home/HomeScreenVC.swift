//
//  HomeScreenVC.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class HomeScreenVC: RmBaseVC {
    
    public static func getInstance() -> HomeScreenVC {
        let vc = HomeScreenVC()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    override func onScreenStarted() {
        super.onScreenStarted()
        
        // Add Child ViewController in Home ViewController
        let child = HomeScreenContentTabViewController.getInstance()
        add(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

    }

}
