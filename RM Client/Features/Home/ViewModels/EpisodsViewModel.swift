//
//  EpisodsViewModel.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation

public class EpisodsViewModel: RmBaseViewModel<EpisodsAction> {
    
    private var useCase: GetEpisodsUseCase? = nil
    let loadingState: RmViewModelState<Bool> = RmViewModelState()
    let listState: RmViewModelState<[RmEpisodeModel]> = RmViewModelState()
    
    public override func onPerformAction(action: EpisodsAction) {
        if action is EpisodsAction.GetEpisodsAction {
            getEpisodsList()
        }
    }
    
    private func getEpisodsList() {
        let listStateValue = listState.getValue() ?? []
        if listStateValue.isEmpty == true {
            getEpisodsUseCaseInstance().execute()
        }
    }
    
    private func getEpisodsUseCaseInstance() -> GetEpisodsUseCase {
        if useCase == nil {
            useCase = GetEpisodsUseCase(
                dispatchQueue: getDispatchQueue(),
                listener: GetEpisodsUseCaseListener(viewModel: self)
            )
        }
        
        return useCase!
    }
    
    public override func getViewModelTitle() -> String {
        return "EpisodsViewModel"
    }
    
    deinit {
        getEpisodsUseCaseInstance().onDestroyUseCase()
    }
    
}
