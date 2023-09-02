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
        
    }
    
    override func onLoadingState(newState: Bool) {
        viewModel.homeScreenLoadingState.onPostValue(value: newState)
    }
}
