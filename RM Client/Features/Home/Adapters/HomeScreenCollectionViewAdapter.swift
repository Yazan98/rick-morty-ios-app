//
//  RmCollectionViewAdapter.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation
import UIKit

class HomeScreenCollectionViewAdapter : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let itemsList: [HomeScreenItem]
    
    init(itemsList: [HomeScreenItem]) {
        self.itemsList = itemsList
    }
    
    
}
