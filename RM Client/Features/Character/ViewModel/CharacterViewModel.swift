//
//  CharacterViewModel.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation
import RealmSwift

public final class CharacterViewModel: RmBaseViewModel<CharacterAction> {
    
    private var useCaseInstance: GetCharacterInfoUseCase? = nil
    let screenState: RmViewModelState<[CharacterItem]> = RmViewModelState()
    let loadingState: RmViewModelState<Bool> = RmViewModelState()
    let otherNavigationState: RmViewModelState<[CharacterOtherInfoItem]> = RmViewModelState()
    
    public override func onPerformAction(action: CharacterAction) {
        if action is CharacterAction.GetCharacterInfoAction {
            self.getScreenContent(
                id: (action as! CharacterAction.GetCharacterInfoAction).id,
                action: action
            )
        } else if action is CharacterAction.GetCharacterInfoByOtherCharacters {
            let id = (action as! CharacterAction.GetCharacterInfoByOtherCharacters).id
            self.getScreenContent(
                id: id,
                action: action
            )
            
            self.getOtherNavigationItems(id: id)
        }
    }
    
    private func getOtherNavigationItems(id: Int64) {
        getDispatchQueue().async { [weak self] in
            self?.otherNavigationState.onPostValue(value: self?.getUseCase().getOtherCharactersList(id: id) ?? [])
        }
    }
    
    private func getScreenContent(id: Int64, action: CharacterAction) {
        let screenContent = screenState.getValue() ?? []
        if screenContent.isEmpty {
            getUseCase().onExecute(props: self.getUseCaseProp(
                id: id,
                action: action)
            )
        }
    }
    
    private func getUseCaseProp(id: Int64, action: CharacterAction) -> GetCharacterInfoUseCaseProps {
        return GetCharacterInfoUseCaseProps(
            id: id,
            isInfoAction: action is CharacterAction.GetCharacterInfoAction
        )
    }
    
    private func getUseCase() -> GetCharacterInfoUseCase {
        if useCaseInstance == nil {
            useCaseInstance = GetCharacterInfoUseCase(
                dispatchQueue: getDispatchQueue(),
                listener: GetCharacterInfoUseCaseListener(viewModel: self)
            )
        }
        
        return useCaseInstance!
    }
    
    public override func getViewModelTitle() -> String {
        return "CharacterViewModel"
    }
    
    deinit {
        getUseCase().onDestroyUseCase()
    }
    
}
