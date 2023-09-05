//
//  GetCharactersListUseCase.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation

public final class GetCharactersUseCase: RmUseCase<[RmCharacterModel]> {
    
    public override func execute() {
        getDispatchQueueInstance().async { [weak self] in
            if self?.isLocalListEmpty() == true {
                self?.onSubmitLoadingValue(newState: true)
                self?.getCharactersList(onCompletion: { list in
                    self?.onSubmitLoadingValue(newState: false)
                    self?.onSubmitResponseValue(value: list)
                    self?.onWriteLocalDataList(list: list)
                })
            } else {
                self?.onSubmitResponseValue(value: self?.getLocalCharactersList() ?? [])
            }
        }
    }
    
    private func getCharactersList(
        onCompletion: @escaping ([RmCharacterModel]) -> Void
    ) {
        RmRequestManager.shared.onExecuteSingleRequest(
            requestInfo: RmRequestInfo(
                requestMethod: .get,
                requestUrl: RmRequestUrl.shared.getCharacters(),
                queryParams: [:],
                dispatchQueue: getDispatchQueueInstance()
            ),
            responseType: RmListResponse<RmCharacterModel>.self) { response in
                onCompletion(response.results ?? [])
            } onErrorResponse: { error in
                // Read From Realm When Build Database
                onCompletion([])
            }
    }
    
    private func getLocalCharactersList() -> [RmCharacterModel] {
        return []
    }
    
    private func onWriteLocalDataList(list: [RmCharacterModel]) {
        getDispatchQueueInstance().async {
            
        }
    }
    
    private func isLocalListEmpty() -> Bool {
        return true
    }
    
}

public final class GetCharactersUseCaseListener: RmUseCaseListener<[RmCharacterModel]> {
    
    let viewModel: CharactersViewModel
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    public override func onLoadingState(newState: Bool) {
        viewModel.loadingState.onPostValue(value: newState)
    }
    
    public override func onSuccessResponse(response: [RmCharacterModel]) {
        viewModel.screenState.onPostValue(value: response)
    }
}
