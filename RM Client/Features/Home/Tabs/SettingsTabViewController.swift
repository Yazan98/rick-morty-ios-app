//
//  LocationsTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class SettingsTabViewController: RmBaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var settingsCollectionView: UICollectionView!
    
    public static func getInstance() -> SettingsTabViewController {
        return SettingsTabViewController()
    }

    override func onScreenStarted() {
        super.onScreenStarted()
    }
    
    override func setupViewsContent() {
        super.setupViewsContent()        
        self.settingsCollectionView?.register(
            UINib(nibName: "SettingsItemCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "SettingsCell"
        )
        
        self.settingsCollectionView?.delegate = self
        self.settingsCollectionView?.dataSource = self
        self.settingsCollectionView?.reloadData()
        
        settingsCollectionView?.reloadData()
    }
    
    override func getTitle() -> String {
        return "settings".getLocalizedString()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SettingsCell",
            for: indexPath
        ) as! SettingsItemCollectionViewCell
        
        cellView.configure(item: RmSettingsItem.shared[indexPath.section])
                    
        return cellView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 60)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return RmSettingsItem.shared.count
    }

}
