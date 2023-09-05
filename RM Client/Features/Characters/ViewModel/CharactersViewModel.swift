//
//  CharactersViewModel.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public final class CharactersViewModel: RmBaseViewModel<CharactersAction> {
    
    private var useCaseInstance: GetCharactersUseCase? = nil
    let screenState: RmViewModelState<[RmCharacterModel]> = RmViewModelState()
    let loadingState: RmViewModelState<Bool> = RmViewModelState()
    
    public override func onPerformAction(action: CharactersAction) {
        if action is CharactersAction.GetCharactersListAction {
            self.getCharactersList()
        }
    }
    
    private func getCharactersList() {
        let stateValue = screenState.getValue() ?? []
        if stateValue.isEmpty {
            getUseCase().execute()
        }
    }
    
    private func getUseCase() -> GetCharactersUseCase {
        if self.useCaseInstance == nil {
            self.useCaseInstance = GetCharactersUseCase(
                dispatchQueue: self.getDispatchQueue(),
                listener: GetCharactersUseCaseListener(viewModel: self)
            )
        }
        return self.useCaseInstance!
    }
    
    deinit {
        getUseCase().onDestroyUseCase()
    }
    
}
