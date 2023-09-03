//
//  HomeScreenNotificationsPermissionItem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation

public struct HomeScreenNotificationsPermissionItem: HomeScreenItem {
    public func getIdentifire() -> String {
        return HomeScreenItemConsts.HOME_SCREEN_NOTIFICATION_PERMISSION
    }
}
