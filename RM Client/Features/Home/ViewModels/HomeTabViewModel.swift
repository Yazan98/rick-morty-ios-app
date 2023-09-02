//
//  HomeTabViewModel.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation

public class HomeTabViewModel: RmBaseViewModel<HomeTabAction> {
    
    public let homeScreenItemsState: RmViewModelState<[HomeScreenItem]> = RmViewModelState()
    public let homeScreenLoadingState: RmViewModelState<Bool> = RmViewModelState()
    
    private var screenUseCase: GetHomeScreenItemsVerticalListUseCase? = nil
    
    
    public override func onPerformAction(action: HomeTabAction) {
        if action is HomeTabAction.GetVerticalListInfoAction {
            getVerticalListInfo()
        } else if action is HomeTabAction.GetGridListInfoAction {
            getGridListInfo()
        }
    }
    
    private func getVerticalListInfo() {
        if homeScreenItemsState.getValue() == nil {
            getHomeScreenItemsUseCase().execute()
        }
    }
    
    private func getGridListInfo() {
        
    }
    
    private func getHomeScreenItemsUseCase() -> GetHomeScreenItemsVerticalListUseCase {
        if screenUseCase == nil {
            screenUseCase = GetHomeScreenItemsVerticalListUseCase(
                dispatchQueue: getDispatchQueue(),
                listener: GetHomeScreenItemsVerticalListUseCaseListener(viewModel: self)
            )
        }
        
        return screenUseCase!
    }
    
    deinit {
        homeScreenItemsState.onDestroy()
    }
    
}
