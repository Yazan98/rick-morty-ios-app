//
//  HomeTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class HomeTabViewController: RmBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        viewModel.homeScreenItemsState.onSubscribe { [self] state in
            onInitCollectionViewData(items: state)
        }
        
        viewModel.homeScreenLoadingState.onSubscribe { loading in
            self.onLoadingState(view: self.loadingView, loadingState: loading)
            if loading == true {
                self.screenCollectionView?.isHidden = true
            }
        }
    }
    
    private func onInitCollectionViewData(items: [HomeScreenItem]) {
        self.screenCollectionView?.dataSource = self
        self.screenCollectionView?.delegate = self
        self.screenCollectionView?.isHidden = false
        self.screenCollectionView?.register(
            HomeScreenHeaderCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_HEADER
        )
        
        self.screenCollectionView?.register(
            HomeScreenHeaderCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_HEADER
        )

        self.screenCollectionView?.register(
            UINib(nibName: "HomeScreenHeaderCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_HEADER
        )

        self.screenCollectionView?.register(
            UINib(nibName: "HomeNotificationsPermissionCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_NOTIFICATION_PERMISSION
        )

        self.screenCollectionView?.register(
            UINib(nibName: "HomeStoragePermissionItemCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: HomeScreenItemConsts.HOME_STORAGE
        )

        self.screenCollectionView?.register(
            UINib(nibName: "HomeScreenCharactersCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: HomeScreenItemConsts.CHARACTERS_LIST
        )
        
        self.screenCollectionView?.reloadData()
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.homeScreenItemsState.getValue()?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let screenItemsList = viewModel.homeScreenItemsState.getValue() ?? []
        
        switch screenItemsList[indexPath.section].getIdentifire() {
        case HomeScreenItemConsts.HOME_SCREEN_HEADER:
            return CGSize(width: UIScreen.main.bounds.width - 20, height: 90)
        case HomeScreenItemConsts.HOME_SCREEN_NOTIFICATION_PERMISSION:
            return CGSize(width: UIScreen.main.bounds.width - 2, height: 190)
        case HomeScreenItemConsts.HOME_STORAGE:
            return CGSize(width: UIScreen.main.bounds.width - 2, height: 290)
        case HomeScreenItemConsts.CHARACTERS_LIST:
            return CGSize(width: UIScreen.main.bounds.width - 2, height: 350)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        var content: [HomeScreenItem] = []
        if viewModel.homeScreenItemsState.getValue() != nil {
            content = viewModel.homeScreenItemsState.getValue() ?? []
        }
        
        switch content[indexPath.section].getIdentifire() {
        case HomeScreenItemConsts.HOME_SCREEN_HEADER:
            let headerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_HEADER,
                for: indexPath
            ) as! HomeScreenHeaderCollectionViewCell
                        
            return headerCell
        
        case HomeScreenItemConsts.CHARACTERS_LIST:
            guard let cell = content[indexPath.section] as? HomeScreenCharactersListItem else {
                return HomeScreenCharactersCollectionViewCell()
            }
            
            let headerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeScreenItemConsts.CHARACTERS_LIST,
                for: indexPath
            ) as! HomeScreenCharactersCollectionViewCell
            
            headerCell.configure(item: cell)
                        
            return headerCell
            
        case HomeScreenItemConsts.HOME_STORAGE:
            let headerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeScreenItemConsts.HOME_STORAGE,
                for: indexPath
            ) as! HomeStoragePermissionItemCollectionViewCell
                        
            return headerCell
            
        case HomeScreenItemConsts.HOME_SCREEN_NOTIFICATION_PERMISSION:
            let headerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_NOTIFICATION_PERMISSION,
                for: indexPath
            ) as! HomeNotificationsPermissionCollectionViewCell
                        
            return headerCell
        default:
            let headerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeScreenItemConsts.HOME_SCREEN_HEADER,
                for: indexPath
            ) as! HomeScreenHeaderCollectionViewCell
            
            return headerCell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    
    override func setupViewsContent() {
        super.setupViewsContent()
        self.navigationItem.rightBarButtonItem = listSortingButton
        screenCollectionView?.backgroundColor = .systemBackground
    }
    
    override func getTitle() -> String {
        return "home".getLocalizedString()
    }

    @objc func onListSortingClickListener() {
        
    }
    
    @objc func onGridSortingClickListener() {
        
    }

}
