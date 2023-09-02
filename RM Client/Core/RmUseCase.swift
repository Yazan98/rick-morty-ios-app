//
//  RmUseCase.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation

public class RmUseCase<Response> {
    
    private var dispatchQueue: DispatchQueue? = nil
    private var listener: RmUseCaseListener<Response>? = nil
    
    init(dispatchQueue: DispatchQueue? = nil, listener: RmUseCaseListener<Response>? = nil) {
        self.dispatchQueue = dispatchQueue
        self.listener = listener
    }
    
    // Childs Should Fill this Function
    public func execute() {}
    
    public func onSubmitResponseValue(value: Response) {
        self.listener?.onSuccessResponse(response: value)
    }
    
    public func onSubmitLoadingValue(newState: Bool) {
        self.listener?.onLoadingState(newState: newState)
    }
    
    public func onSubmitErrorValue(value: Error) {
        self.listener?.onErrorResponse(error: value)
    }
    
    public func getDispatchQueueInstance() -> DispatchQueue {
        return dispatchQueue ?? DispatchQueue(label: "Unknown UseCase Type")
    }
    
    public func onDestroyUseCase() {
        dispatchQueue?.suspend()
        dispatchQueue = nil
        listener = nil
    }
    
}
