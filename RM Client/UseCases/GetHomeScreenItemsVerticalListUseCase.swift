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
            
            // 2. Notifications Permission
            if RmPermissionsManager.shared.isNotificationsPermissionEnabled() == false {
                screenItems.append(HomeScreenNotificationsPermissionItem())
            }
            
            // 3. List of Characters
            self?.getCharachets(query: ["status": "alive"]) { result in
                screenItems.append(HomeScreenCharactersListItem(
                    list: result,
                    sectionName: "section_alive".getLocalizedString()
                ))
                
                // 3. Storage Permission
                if RmPermissionsManager.shared.isStoragePermissionEnabled() == false {
                    screenItems.append(HomeScreenStorageItem())
                }
                
                self?.onSubmitLoadingValue(newState: false)
                self?.onSubmitResponseValue(value: screenItems)
            }
        }
    }
    
    private func getCharachets(query: [String:String], onComplete: @escaping ([RmCharacterModel]) -> Void) {
        RmRequestManager.shared.onExecuteSingleRequest(
            requestInfo: RmRequestInfo(
                requestMethod: .get,
                requestUrl: RmRequestUrl.shared.getCharacters(),
                queryParams: query,
                dispatchQueue: getDispatchQueueInstance()
            ),
            responseType: RmListResponse<RmCharacterModel>.self) { response in
                onComplete(response.results ?? [])
            } onErrorResponse: { error in
                // Read From Realm When Build Database
                onComplete([])
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
