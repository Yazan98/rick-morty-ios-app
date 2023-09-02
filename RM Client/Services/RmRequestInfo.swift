//
//  RmRequestInfo.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation

public struct RmRequestInfo {
    let requestMethod: RmRequestMethod
    let requestUrl: String
    let queryParams: [String: String]?
    let dispatchQueue: DispatchQueue
}
