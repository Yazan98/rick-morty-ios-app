//
//  RmBaseViewModel.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation

public class RmBaseViewModel<Action: RmAction> {
    
    private weak var dispatchQueueInstance: DispatchQueue? = nil
    
    public func getDispatchQueue() -> DispatchQueue {
        if dispatchQueueInstance == nil {
            dispatchQueueInstance = DispatchQueue(label: getViewModelTitle(), qos: .background)
        }
        
        return self.dispatchQueueInstance ?? DispatchQueue(label: getViewModelTitle(), qos: .background)
    }
    
    // Child File Will Handle this Actions
    public func onPerformAction(action: Action) { }
    
    public func getViewModelTitle() -> String {
        return "Unknown"
    }
    
}
