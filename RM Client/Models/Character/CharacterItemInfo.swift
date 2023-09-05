//
//  CharacterItemInfo.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public final class CharacterItemInfo: CharacterItem {
    
    let name: String
    let value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    public func getIdentifire() -> String {
        return CharacterItemConsts.CHARACTER_INFO_ITEM
    }
    
}
