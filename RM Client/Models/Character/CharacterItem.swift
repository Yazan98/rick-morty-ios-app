//
//  Characteritem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public protocol CharacterItem {
            
    func getIdentifire() -> String
    
}

public class CharacterItemConsts {
    public static let CHARACTER_HEADER = "CharacterHeader"
    public static let CHARACTER_INFO_ITEM = "CharacterInfo"
    public static let CHARACTER_INFO_OTHER = "CharacterOther"
}
