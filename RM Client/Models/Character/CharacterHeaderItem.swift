//
//  CharacterHeaderItem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public final class CharacterHeaderItem: CharacterItem {
    
    let name: String
    let image: String
    let description: String
    
    init(name: String, image: String, description: String) {
        self.name = name
        self.image = image
        self.description = description
    }
    
    public func getIdentifire() -> String {
        return CharacterItemConsts.CHARACTER_HEADER
    }
}
