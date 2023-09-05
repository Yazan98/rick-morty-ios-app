//
//  HomeScreenCharactersCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class HomeScreenCharactersCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var onItemClickListener: ((RmCharacterModel) -> Void)? = nil
    private var onViewMoreClickLIstener: (() -> Void?)? = nil
    private var list: [RmCharacterModel] = []

    @IBOutlet weak var sectionViewMore: UIButton!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var innerCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionViewMore?.setTitle("section_view_more".getLocalizedString(), for: .normal)
    }
    
    public func configure(
        item: HomeScreenCharactersListItem,
        onItemClickListener: @escaping (RmCharacterModel) -> Void,
        onViewMoreClickLIstener: @escaping () -> Void
    ) {
        self.onItemClickListener = onItemClickListener
        self.onViewMoreClickLIstener = onViewMoreClickLIstener
        
        sectionTitle?.text = item.sectionName
        list = item.list
        
        innerCollectionView?.dataSource = self
        innerCollectionView?.delegate = self
        
        self.innerCollectionView?.register(
            UINib(nibName: "CharacterHorizantelCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "Cell"
        )
        
        innerCollectionView?.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = list[indexPath.section]
        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        ) as! CharacterHorizantelCollectionViewCell
        
        cellView.configure(item: cell)
                    
        return cellView
    }
    
    @IBAction func onViewMoreClickListener(_ sender: Any) {
        if onViewMoreClickLIstener != nil {
            self.onViewMoreClickLIstener!()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) + 40, height: 300)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = list[indexPath.section]        
        if self.onItemClickListener != nil {
            self.onItemClickListener!(item)
        }
    }
    

}
