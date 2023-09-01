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
        "welcome_title_1".getLocalizedString(),
        "welcome_title_2".getLocalizedString(),
        "welcome_title_3".getLocalizedString()
    ]
    
    private let messages = [
        "welcome_message_1".getLocalizedString(),
        "welcome_message_2".getLocalizedString(),
        "welcome_message_3".getLocalizedString()
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
            continueButtonInstance?.isEnabled = true
        } else {
            continueButtonInstance?.isHidden = true
        }

        imageViewInstance?.image = UIImage(named: "OnBoardingImage\(tabIndex + 1)")
        tabTitleLabel?.text = titles[tabIndex]
        tabDescriptionLabel?.text = messages[tabIndex]
        continueButtonInstance?.addTarget(self, action: #selector(onContinueButtonListener), for: .touchUpInside)
    }
    
    @objc func onContinueButtonListener(_ sender: Any) {
        RmLocalStorage.shared.onUpdateAppOpeningStatus(newStatus: true)
        self.navigationController?.pushViewController(AuthScreenVC.getInstance(), animated: true)
    }
    
    public func addTabIndex(index: Int) {
        self.tabIndex = index
    }

}
