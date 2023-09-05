//
//  RmBaseVC.swift
//  RM Client
//
//  Created by Yazan Tarifi on 31/08/2023.
//

import Foundation
import UIKit

public class RmBaseVC : UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .systemBackground
        setupListeners()
        onScreenStarted()
        setupViewsContent()
    }
    
    public func onPushViewController(vc: RmBaseVC) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func onPushInsideEmbeddedNavController(vc: RmBaseVC) {
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.pushViewController(navigationController, animated: true)
    }
    
    public func onPresentInsideEmbeddedNavController(vc: RmBaseVC) {
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    public func onPushViewController(vc: UITabBarController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func setupListeners() {
        // Setup Listeners Will be Filled in Each VC
    }
    
    public func setupViewsContent() {
        // Setup subViews Inflated from Nib File
    }
    
    public func onCenterViewConstraints(targetView: UIView) {
        NSLayoutConstraint.activate([
            targetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            targetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            targetView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            targetView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    public func onLoadingState(view: UIActivityIndicatorView?, loadingState: Bool) {
        if loadingState {
            view?.isHidden = false
            view?.startAnimating()
        } else {
            view?.isHidden = true
            view?.stopAnimating()
        }
    }
    
    public func onPushPresentStackView(vc: RmBaseVC) {
        self.present(vc, animated: true, completion: nil)
    }
    
    public func onPushPresentStackView(vc: UITabBarController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    public func onScreenStarted() {
        if !getTitle().isEmpty {
            title = getTitle()
        }
        
        if isLargeToolbarEnabled() {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    public func isLargeToolbarEnabled() -> Bool {
        return true
    }
    
    public func getTitle() -> String {
        return "Rick And Morty"
    }
    
}
