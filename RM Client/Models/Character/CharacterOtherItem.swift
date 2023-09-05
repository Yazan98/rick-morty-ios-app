//
//  CharacterOtherItem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public final class CharacterOtherItem: CharacterItem {
    
    let list: [CharacterOtherInfoItem]
    init(list: [CharacterOtherInfoItem]) {
        self.list = list
    }
    
    public func getIdentifire() -> String {
        return CharacterItemConsts.CHARACTER_INFO_OTHER
    }
}
