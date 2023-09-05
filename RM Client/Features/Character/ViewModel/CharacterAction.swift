//
//  CharacterAction.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public class CharacterAction: RmAction {
    public final class GetCharacterInfoAction: CharacterAction {
        let id: Int64
        init(id: Int64) {
            self.id = id
        }
    }
    
    public final class GetCharacterInfoByOtherCharacters: CharacterAction {
        let id: Int64
        init(id: Int64) {
            self.id = id
        }
    }
}
