//
//  HomeTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class HomeTabViewController: RmBaseVC {
    
    public static func getInstance() -> HomeTabViewController {
        return HomeTabViewController()
    }
    
    @IBOutlet weak var screenCollectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    private let viewModel = HomeTabViewModel()
    private var listSortingButton: UIBarButtonItem = {
       let gridImage = UIImage(systemName: "circle.grid.2x2.fill")?.withRenderingMode(.alwaysOriginal)
       let button = UIBarButtonItem(
        image: gridImage,
        style: .plain,
        target: HomeTabViewController.self,
        action:  #selector(onListSortingClickListener)
       )
        
        return button
    }()
    
    private var gridSortingButton: UIBarButtonItem = {
       let listImage = UIImage(systemName: "list.bullet.indent")?.withRenderingMode(.alwaysOriginal)
       let button = UIBarButtonItem(
        image: listImage,
        style: .plain,
        target: HomeTabViewController.self,
        action:  #selector(onGridSortingClickListener)
       )
                
        return button
    }()

    override func onScreenStarted() {
        super.onScreenStarted()
        viewModel.onPerformAction(action: HomeTabAction.GetVerticalListInfoAction())
    }
    
    override func setupListeners() {
        super.setupListeners()
        viewModel.homeScreenItemsState.onSubscribe { state in
            
        }
        
        viewModel.homeScreenLoadingState.onSubscribe { loading in
            self.onLoadingState(view: self.loadingView, loadingState: loading)
        }
    }
    
    override func setupViewsContent() {
        super.setupViewsContent()
        self.navigationItem.rightBarButtonItem = listSortingButton
    }
    
    override func getTitle() -> String {
        return "home".getLocalizedString()
    }

    @objc func onListSortingClickListener() {
        
    }
    
    @objc func onGridSortingClickListener() {
        
    }

}
