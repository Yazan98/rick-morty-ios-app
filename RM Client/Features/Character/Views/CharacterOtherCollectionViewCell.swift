//
//  CharacterOtherCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import UIKit

class CharacterOtherCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var clickListener: ((Int64, String) -> Void)? = nil
    private var list: [CharacterOtherInfoItem] = []
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var innerCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView?.text = "characters_other".getLocalizedString()
    }
    
    public func onLoadData(item: CharacterOtherItem, click: @escaping (Int64, String) -> Void) {
        self.list = item.list
        self.clickListener = click
        self.onSetupScreenCollectionView()
    }
    
    private func onSetupScreenCollectionView() {
        self.innerCollectionView?.isHidden = false
        self.innerCollectionView?.register(
            UINib(nibName: "CharacterOtherImageCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CharacterOtherImage"
        )
        
        self.innerCollectionView?.delegate = self
        self.innerCollectionView?.dataSource = self
        self.innerCollectionView?.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = list[indexPath.section]
        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CharacterOtherImage",
            for: indexPath
        ) as! CharacterOtherImageCollectionViewCell
        
        cellView.onLoadImage(item: cell)
        return cellView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 2, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.list[indexPath.section]
        if clickListener != nil {
            clickListener!(cell.id, cell.name)
        }
    }
    
}
