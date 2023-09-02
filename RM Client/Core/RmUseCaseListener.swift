//
//  RmUseCaseListener.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation

public class RmUseCaseListener<Response> {
    public func onSuccessResponse(response: Response) {}
    public func onErrorResponse(error: Error) {}
    public func onLoadingState(newState: Bool) {}
}
