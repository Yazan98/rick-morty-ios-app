//
//  GetEpisodsUseCase.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation

public final class GetEpisodsUseCase: RmUseCase<[RmEpisodeModel]> {
    
    public override func execute() {
        getDispatchQueueInstance().async { [weak self] in
            self?.onSubmitLoadingValue(newState: true)
            self?.getEpisodsList(onComplete: { response in
                self?.onSubmitLoadingValue(newState: false)
                self?.onSubmitResponseValue(value: response)
            })
        }
    }
    
    private func getEpisodsList(onComplete: @escaping ([RmEpisodeModel]) -> Void) {
        RmRequestManager.shared.onExecuteSingleRequest(
            requestInfo: RmRequestInfo(
                requestMethod: .get,
                requestUrl: RmRequestUrl.shared.getEpisodsList(),
                queryParams: [:],
                dispatchQueue: getDispatchQueueInstance()
            ),
            responseType: RmListResponse<RmEpisodeModel>.self,
            onSuccessResponse: { response in
                onComplete(response.results ?? [])
            }) { error in
                
            }
    }
    
}

public final class GetEpisodsUseCaseListener: RmUseCaseListener<[RmEpisodeModel]> {
    
    let viewModel: EpisodsViewModel
    init (viewModel: EpisodsViewModel) {
        self.viewModel = viewModel
    }
    
    public override func onErrorResponse(error: Error) {
        // Handle Error Screen
    }
    
    public override func onSuccessResponse(response: [RmEpisodeModel]) {
        self.viewModel.listState.onPostValue(value: response)
    }
    
    public override func onLoadingState(newState: Bool) {
        self.viewModel.loadingState.onPostValue(value: newState)
    }
}
