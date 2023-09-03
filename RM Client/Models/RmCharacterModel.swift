//
//  RmCharacterModel.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation

public struct RmCharacterModel: RmBaseModel {
    let id: Int64?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let url: String?
    let image: String?
    let episode: [String]?
    let location: RmCharacterLocation?
}

public struct RmCharacterLocation: Codable {
    let name: String?
}
