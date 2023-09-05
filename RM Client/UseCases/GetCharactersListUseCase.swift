//
//  GetCharactersListUseCase.swift
//  RM Client
//
//  Created by Yazan Tarifi on 05/09/2023.
//

import Foundation
import RealmSwift

public final class GetCharactersUseCase: RmUseCase<[RmCharacterModel]> {
    
    public override func execute() {
        getDispatchQueueInstance().async { [weak self] in
            let cachedCharactersList = self?.getLocalCharactersList() ?? []
            if cachedCharactersList.isEmpty {
                self?.onSubmitLoadingValue(newState: true)
                self?.getCharactersList(onCompletion: { list in
                    self?.onSubmitLoadingValue(newState: false)
                    self?.onSubmitResponseValue(value: list)
                    self?.onWriteLocalDataList(list: list)
                })
            } else {
                self?.onSubmitLoadingValue(newState: false)
                self?.onSubmitResponseValue(value: cachedCharactersList)
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
        let realm = try! Realm()
        var results: [RmCharacterModel] = []
        let charactersCachedList = realm.objects(RmCharacterEntity.self)
        let sectionCharacters = charactersCachedList.sorted { firstEntity, secondEntity in
            firstEntity.order < secondEntity.order
        }
        
        sectionCharacters.forEach { cachedItem in
            results.append(RmCharacterEntity.map(item: cachedItem))
        }

        return results
    }
    
    private func onWriteLocalDataList(list: [RmCharacterModel]) {
        getDispatchQueueInstance().async {
            let realm = try! Realm()
            for (index,item) in list.enumerated() {
                try! realm.write {
                    realm.add(RmCharacterEntity.map(
                        order: index,
                        item: item
                    ), update: .modified)
                }
            }
        }
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
