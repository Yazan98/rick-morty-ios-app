//
//  GetHomeScreenItemsVerticalListUseCase.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation

public class GetHomeScreenItemsVerticalListUseCase : RmUseCase<[HomeScreenItem]> {
    
    public override func execute() {
        getDispatchQueueInstance().async { [weak self] in
            self?.onSubmitLoadingValue(newState: true)
            var screenItems: [HomeScreenItem] = []
            
            // 1. Header Item
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            screenItems.append(HomeScreenHeaderItem())
            
            // 2. Notifications Permission
//            if RmPermissionsManager.shared.isNotificationsPermissionEnabled() == false {
//                screenItems.append(HomeScreenNotificationsPermissionItem())
//            }
//
//            if RmPermissionsManager.shared.isNotificationsPermissionEnabled() == false {
//                screenItems.append(HomeScreenNotificationsPermissionItem())
//            }
//
//            if RmPermissionsManager.shared.isNotificationsPermissionEnabled() == false {
//                screenItems.append(HomeScreenNotificationsPermissionItem())
//            }
//
//            if RmPermissionsManager.shared.isNotificationsPermissionEnabled() == false {
//                screenItems.append(HomeScreenNotificationsPermissionItem())
//            }
            
            self?.onSubmitLoadingValue(newState: false)
            self?.onSubmitResponseValue(value: screenItems)
        }
    }
}

class GetHomeScreenItemsVerticalListUseCaseListener : RmUseCaseListener<[HomeScreenItem]> {
    
    let viewModel: HomeTabViewModel
    init(viewModel: HomeTabViewModel) {
        self.viewModel = viewModel
    }
    
    override func onErrorResponse(error: Error) {
        
    }
    
    override func onSuccessResponse(response: [HomeScreenItem]) {
        viewModel.homeScreenItemsState.onPostValue(value: response)
    }
    
    override func onLoadingState(newState: Bool) {
        viewModel.homeScreenLoadingState.onPostValue(value: newState)
    }
}
