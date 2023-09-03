//
//  HomeScreenCharactersListItem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation

public struct HomeScreenCharactersListItem: HomeScreenItem {
    
    let list: [RmCharacterModel]
    let sectionName: String
    
    public func getIdentifire() -> String {
        return HomeScreenItemConsts.CHARACTERS_LIST
    }
}
