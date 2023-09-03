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
            
            // 2. List of Characters
            self?.getCharachets(query: ["status": "alive"]) { result in
                if result.isEmpty == false {
                    screenItems.append(HomeScreenCharactersListItem(
                        list: result,
                        sectionName: "section_alive".getLocalizedString()
                    ))
                }
                
                // 3. Notifications Permission
                if RmPermissionsManager.shared.isNotificationsPermissionEnabled() == false {
                    screenItems.append(HomeScreenNotificationsPermissionItem())
                }
                
                // 4. Male Characters
                self?.getCharachets(query: ["gender": "male"]) { result in
                    if result.isEmpty == false {
                        screenItems.append(HomeScreenCharactersListItem(
                            list: result.reversed(),
                            sectionName: "section_male".getLocalizedString()
                        ))
                    }
                    
                    // 5. Storage Permission
                    if RmPermissionsManager.shared.isStoragePermissionEnabled() == false {
                        screenItems.append(HomeScreenStorageItem())
                    }
                    
                    // 6. Male Characters
                    self?.getCharachets(query: ["gender": "female"]) { result in
                        if result.isEmpty == false {
                            screenItems.append(HomeScreenCharactersListItem(
                                list: result.reversed(),
                                sectionName: "section_female".getLocalizedString()
                            ))
                        }
                        
                        self?.onSubmitLoadingValue(newState: false)
                        self?.onSubmitResponseValue(value: screenItems)
                    }
                }
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
