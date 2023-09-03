//
//  RmListResponse.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation

public struct RmListResponse<T: Codable>: RmBaseModel {
    let info: RmListPaginationInfo?
    let results: [T]?
}


public struct RmListPaginationInfo: RmBaseModel {
    let count: Int?
    let pages: Int?
}
