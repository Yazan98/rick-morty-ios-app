//
//  CharacterScreenViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 04/09/2023.
//

import UIKit

class CharacterScreenViewController: RmBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var id: Int64 = 0
    var name: String = ""
    var isOtherAction: Bool = false
    private let viewModel: CharacterViewModel = CharacterViewModel()
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var screenContentCollectionView: UICollectionView!
    @IBOutlet weak var otherNavigationCollectionView: UICollectionView!
    
    public static func getInstance(id: Int64, name: String) -> CharacterScreenViewController {
        let vc = CharacterScreenViewController()
        vc.id = id
        vc.name = name
        return vc
    }
    
    public static func getInstance(id: Int64, name: String, isOtherAction: Bool) -> CharacterScreenViewController {
        let vc = CharacterScreenViewController()
        vc.id = id
        vc.name = name
        vc.isOtherAction = isOtherAction
        return vc
    }
    
    override func onScreenStarted() {
        super.onScreenStarted()
        if isOtherAction {
            viewModel.onPerformAction(action: CharacterAction.GetCharacterInfoByOtherCharacters(id: id))
        } else {
            viewModel.onPerformAction(action: CharacterAction.GetCharacterInfoAction(id: id))
        }
    }
    
    override func setupListeners() {
        super.setupListeners()
        viewModel.screenState.onSubscribe { items in
            self.onSetupScreenCollectionView()
        }
        
        viewModel.loadingState.onSubscribe { status in
            self.onLoadingState(view: self.loadingView, loadingState: status)
            if status {
                self.screenContentCollectionView.isHidden = true
            }
        }
        
        viewModel.otherNavigationState.onSubscribe { list in
            
        }
    }
    
    private func onSetupScreenCollectionView() {
        self.screenContentCollectionView?.isHidden = false
        self.screenContentCollectionView?.register(
            UINib(nibName: "CharacterHeaderCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CharacterItemConsts.CHARACTER_HEADER
        )
        
        self.screenContentCollectionView?.register(
            UINib(nibName: "CharacterInfoItemCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CharacterItemConsts.CHARACTER_INFO_ITEM
        )
        
        self.screenContentCollectionView?.register(
            UINib(nibName: "CharacterOtherCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CharacterItemConsts.CHARACTER_INFO_OTHER
        )
        
        self.screenContentCollectionView?.delegate = self
        self.screenContentCollectionView?.dataSource = self
        self.screenContentCollectionView?.reloadData()
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
        switch cell?.getIdentifire() {
        case CharacterItemConsts.CHARACTER_HEADER:
            let cellView = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterItemConsts.CHARACTER_HEADER,
                for: indexPath
            ) as! CharacterHeaderCollectionViewCell
            
            cellView.configure(item: cell as! CharacterHeaderItem)
            return cellView
        
        case CharacterItemConsts.CHARACTER_INFO_ITEM:
            let cellView = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterItemConsts.CHARACTER_INFO_ITEM,
                for: indexPath
            ) as! CharacterInfoItemCollectionViewCell
            
            cellView.configure(item: cell as! CharacterItemInfo)
            return cellView
            
        case CharacterItemConsts.CHARACTER_INFO_OTHER:
            let cellView = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterItemConsts.CHARACTER_INFO_OTHER,
                for: indexPath
            ) as! CharacterOtherCollectionViewCell
            
            cellView.onLoadData(item: cell as! CharacterOtherItem)
            return cellView
            
        default:
            let cellView = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterItemConsts.CHARACTER_HEADER,
                for: indexPath
            ) as! CharacterHeaderCollectionViewCell
            
            cellView.configure(item: cell as! CharacterHeaderItem)
            return cellView
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cell = viewModel.screenState.getValue()?[indexPath.section]
        switch cell?.getIdentifire() {
        case CharacterItemConsts.CHARACTER_HEADER:
            return CGSize(width: UIScreen.main.bounds.width - 2, height: 340)
        case CharacterItemConsts.CHARACTER_INFO_ITEM:
            return CGSize(width: UIScreen.main.bounds.width - 2, height: 50)
        case CharacterItemConsts.CHARACTER_INFO_OTHER:
            let itemsCount = (cell as! CharacterOtherItem).list.count
            return CGSize(width: Int(UIScreen.main.bounds.width) - 2, height: 50 * itemsCount)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    override func getTitle() -> String {
        return name
    }

}
