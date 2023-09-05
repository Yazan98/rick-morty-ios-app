//
//  CharactersScreenViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharactersScreenViewController: RmBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let viewModel: CharactersViewModel = CharactersViewModel()
    @IBOutlet weak var screenCollectionView: UICollectionView!
    @IBOutlet weak var loadingViewIndicator: UIActivityIndicatorView!
    
    public static func getInstance() -> CharactersScreenViewController {
        return CharactersScreenViewController()
    }

    override func onScreenStarted() {
        super.onScreenStarted()
        viewModel.onPerformAction(action: CharactersAction.GetCharactersListAction())
    }
    
    override func setupListeners() {
        super.setupListeners()
        viewModel.loadingState.onSubscribe { state in
            self.onLoadingState(view: self.loadingViewIndicator, loadingState: state)
            if state {
                self.screenCollectionView.isHidden = true
            }
        }
        
        viewModel.screenState.onSubscribe { response in
            self.screenCollectionView?.isHidden = false
            self.screenCollectionView?.register(
                UINib(nibName: "CharacterVerticalItemCollectionViewCell", bundle: nil),
                forCellWithReuseIdentifier: "CharacterVerticalItemCollectionViewCell"
            )
            
            self.screenCollectionView?.delegate = self
            self.screenCollectionView?.dataSource = self
            self.screenCollectionView?.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.screenState.getValue()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = viewModel.screenState.getValue()?[indexPath.section]
        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CharacterVerticalItemCollectionViewCell",
            for: indexPath
        ) as! CharacterVerticalItemCollectionViewCell
        
        cellView.configure(item: cell)
                    
        return cellView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 2, height: 110)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = viewModel.screenState.getValue()?[indexPath.section]
        self.onPushViewController(vc: CharacterScreenViewController.getInstance(
            id: item?.id ?? 0,
            name: item?.name ?? ""
        ))
    }
    
    override func getTitle() -> String {
        return "characters".getLocalizedString()
    }

}
