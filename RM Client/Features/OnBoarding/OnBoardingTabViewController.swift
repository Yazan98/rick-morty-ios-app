//
//  OnBoardingTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class OnBoardingTabViewController: UIViewController {
    
    @IBOutlet weak var tabTitleLabel: UILabel!
    @IBOutlet weak var imageViewInstance: UIImageView!
    @IBOutlet weak var tabDescriptionLabel: UILabel!
    @IBOutlet weak var continueButtonInstance: UIButton!
    private var tabIndex: Int = 0
    private let titles = [
        "Rick And Morty TV Show",
        "Discover News",
        "Next Version of the Planet"
    ]
    
    private let messages = [
        "Welcome to Rick and Morty IOS Client Application, this is the First Full Demo App Contains Most cases of IOS App Development, Swipe Ma Friendo Swipe",
        "You can Here Descover Characters, Stories, Articles and More, Swipe Ma Friendo Swipe",
        "You Can go to Another Planet in this Application by Trying Morty Expermentals Click Continue to Continue xD"
    ]
   
    public static func getInstance(index: Int) -> OnBoardingTabViewController {
        let vc = OnBoardingTabViewController()
        vc.addTabIndex(index: index)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if tabIndex == 2 {
            continueButtonInstance?.isHidden = false
        } else {
            continueButtonInstance?.isHidden = true
        }

        imageViewInstance?.image = UIImage(named: "OnBoardingImage\(tabIndex + 1)")
        tabTitleLabel?.text = titles[tabIndex]
        tabDescriptionLabel?.text = messages[tabIndex]
    }
    @IBAction func onContinueButtonListener(_ sender: Any) {
        RmLocalStorage.shared.onUpdateAppOpeningStatus(newStatus: true)
        self.navigationController?.pushViewController(HomeScreenVC.getInstance(), animated: true)
    }
    
    public func addTabIndex(index: Int) {
        self.tabIndex = index
    }

}
