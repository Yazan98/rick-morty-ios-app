//
//  GetCharacterInfoUseCase.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation
import RealmSwift

public final class GetCharacterInfoUseCase: RmPropsUseCase<GetCharacterInfoUseCaseProps, [CharacterItem]> {
    
    public override func onExecute(props: GetCharacterInfoUseCaseProps) {
        getDispatchQueueInstance().async { [weak self] in
            self?.getCharacterById(id: props.id, onCompletion: { character in
                self?.onSubmitLoadingValue(newState: false)
                var screenContentItems: [CharacterItem] = []
                
                // 1. Add Header
                screenContentItems.append(CharacterHeaderItem(
                    name: character.name ?? "",
                    image: character.image ?? "",
                    description: character.url ?? ""
                ))
                
                // 2. Add Info
                if let status = character.status {
                    if status.isEmpty == false {
                        screenContentItems.append(CharacterItemInfo(
                            name: "character_status".getLocalizedString(),
                            value: status
                        ))
                    }
                }
                
                if let species = character.species {
                    if species.isEmpty == false {
                        screenContentItems.append(CharacterItemInfo(
                            name: "character_species".getLocalizedString(),
                            value: species
                        ))
                    }
                }
                
                if let gender = character.gender {
                    if gender.isEmpty == false {
                        screenContentItems.append(CharacterItemInfo(
                            name: "character_gender".getLocalizedString(),
                            value: gender
                        ))
                    }
                }
                
                if let type = character.type {
                    if type.isEmpty == false {
                        screenContentItems.append(CharacterItemInfo(
                            name: "character_type".getLocalizedString(),
                            value: type
                        ))
                    }
                }
                
                if let location = character.location {
                    if location.name?.isEmpty == false {
                        screenContentItems.append(CharacterItemInfo(
                            name: "character_location".getLocalizedString(),
                            value: location.name ?? ""
                        ))
                    }
                }
                
                screenContentItems.append(CharacterOtherItem(list: self?.getOtherCharactersList(id: props.id) ?? []))
                
                self?.onSubmitResponseValue(value: screenContentItems)
            })
        }
    }
    
    public func getOtherCharactersList(id: Int64) -> [CharacterOtherInfoItem] {
        var results: [CharacterOtherInfoItem] = []
        
        let realm = try! Realm()
        let charactersCachedList = realm.objects(RmCharacterEntity.self)
        let sectionCharacters = charactersCachedList.where {
            $0.id != id
        }.sorted { firstEntity, secondEntity in
            firstEntity.order < secondEntity.order
        }
        
        sectionCharacters.forEach { cachedItem in
            results.append(CharacterOtherInfoItem(id: cachedItem.id, image: cachedItem.image, name: cachedItem.name))
        }
        
        return results
    }
    
    private func getCharacterById(
        id: Int64,
        onCompletion: @escaping (RmCharacterModel) -> Void
    ) {
        let realm = try! Realm()
        let cachedCharacter = realm.object(ofType: RmCharacterEntity.self, forPrimaryKey: id)
        if cachedCharacter != nil {
            onCompletion(RmCharacterEntity.map(item: cachedCharacter!))
            return
        }
        
        self.onSubmitLoadingValue(newState: true)
        RmRequestManager.shared.onExecuteSingleRequest(
            requestInfo: RmRequestInfo(
                requestMethod: .get,
                requestUrl: RmRequestUrl.shared.getCharactersById(id: id),
                queryParams: [:],
                dispatchQueue: getDispatchQueueInstance()
            ),
            responseType: RmCharacterModel.self) { response in
                onCompletion(response)
            } onErrorResponse: { error in
                onCompletion(RmCharacterEntity.map(item: cachedCharacter!))
            }
    }
}

public final class GetCharacterInfoUseCaseListener: RmUseCaseListener<[CharacterItem]> {
    let viewModel: CharacterViewModel
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
    }
    
    public override func onSuccessResponse(response: [CharacterItem]) {
        viewModel.screenState.onPostValue(value: response)
    }
    
    public override func onLoadingState(newState: Bool) {
        viewModel.loadingState.onPostValue(value: newState)
    }
}

public struct GetCharacterInfoUseCaseProps {
    let id: Int64
    let isInfoAction: Bool
}
