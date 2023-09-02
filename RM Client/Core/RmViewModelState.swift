//
//  RmViewModelState.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation

public final class RmViewModelState<Type> {
    
    private var currentValue: Type? = nil
    private var listener: RmViewModelStateListener<Type>? = nil
    
    public func onSubscribe(callback: @escaping (Type) -> Void) {
        listener = RmViewModelStateListener<Type>(callback: callback)
    }
    
    public func onValue(value: Type) {
        self.currentValue = value
        listener?.onSubscribeValue(value: value)
    }
    
    public func onPostValue(value: Type) {
        DispatchQueue.main.async { [weak self] in
            self?.currentValue = value
            self?.listener?.onSubscribeValue(value: value)
        }
    }
    
    public func getValue() -> Type? {
        return currentValue
    }
    
    public func onDestroy() {
        listener = nil
    }
    
}

public class RmViewModelStateListener<Type> {
    let callback: (Type) -> Void
    init(callback: @escaping (Type) -> Void) {
        self.callback = callback
    }
    
    public func onSubscribeValue(value: Type) {
        callback(value)
    }
}
