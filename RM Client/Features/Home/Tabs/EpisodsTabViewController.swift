//
//  EpisodsTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class EpisodsTabViewController: RmBaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var loadingStateView: UIActivityIndicatorView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    private let viewModel: EpisodsViewModel = EpisodsViewModel()
    public static func getInstance() -> EpisodsTabViewController {
        return EpisodsTabViewController()
    }

    override func onScreenStarted() {
        super.onScreenStarted()
        viewModel.onPerformAction(action: EpisodsAction.GetEpisodsAction())
    }
    
    override func setupListeners() {
        super.setupListeners()
        viewModel.loadingState.onSubscribe { state in
            self.onLoadingState(view: self.loadingStateView, loadingState: state)
            if state {
                self.mainCollectionView?.isHidden = true
            }
        }
        
        viewModel.listState.onSubscribe { state in
            self.mainCollectionView?.isHidden = false
            
            self.mainCollectionView?.register(
                UINib(nibName: "EpisodeCollectionViewCell", bundle: nil),
                forCellWithReuseIdentifier: "Episode"
            )
            
            self.mainCollectionView?.delegate = self
            self.mainCollectionView?.dataSource = self
            self.mainCollectionView?.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.listState.getValue()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = viewModel.listState.getValue()?[indexPath.section]
        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Episode",
            for: indexPath
        ) as! EpisodeCollectionViewCell
        
        cellView.configure(item: cell)
                    
        return cellView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 2, height: 100)
    }
    
    override func getTitle() -> String {
        return "episods".getLocalizedString()
    }

}
