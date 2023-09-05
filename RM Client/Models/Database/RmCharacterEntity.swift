//
//  RmCharacterEntity.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation
import RealmSwift

public class RmCharacterEntity: Object {
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var type: String
    @Persisted var gender: String
    @Persisted var url: String
    @Persisted var image: String
    @Persisted var episode: String?
    @Persisted var locationName: String
    @Persisted var order: Int
    
    public static func map(order: Int, item: RmCharacterModel) -> RmCharacterEntity {
        let result = RmCharacterEntity()
        result.id = item.id ?? 0
        result.status = item.status ?? ""
        result.species = item.species ?? ""
        result.type = item.type ?? ""
        result.gender = item.gender ?? ""
        result.url = item.url ?? ""
        result.name = item.name ?? ""
        result.locationName = item.location?.name ?? ""
        result.image = item.image ?? ""
        result.order = order

        item.episode?.forEach({ imageObject in
            result.episode = imageObject
        })
        
        return result
    }
    
    public static func map(item: RmCharacterEntity) -> RmCharacterModel {
        return RmCharacterModel(
            id: item.id,
            name: item.name,
            status: item.status,
            species: item.species,
            type: item.type,
            gender: item.gender,
            url: item.url,
            image: item.image,
            episode: [item.episode ?? ""],
            location: RmCharacterLocation(name: item.locationName)
        )
    }
}
