//
//  OnBoardingScreenVC.swift
//  RM Client
//
//  Created by Yazan Tarifi on 31/08/2023.
//

import Foundation
import UIKit

public class OnBoardingScreenVC: RmBaseVC {
    
    public static func getInstance() -> OnBoardingScreenVC {
        return OnBoardingScreenVC()
    }
    
    public override func onScreenStarted() {
        super.onScreenStarted()
    }
    
    public override func getTitle() -> String {
        return "Welcome"
    }
    
}
