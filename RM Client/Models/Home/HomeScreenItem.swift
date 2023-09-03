//
//  HomeScreenItem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation

public protocol HomeScreenItem {
            
    func getIdentifire() -> String
    
}

public class HomeScreenItemConsts {
    public static let HOME_SCREEN_HEADER = "Header"
    public static let HOME_SCREEN_NOTIFICATION_PERMISSION = "Notifications"
}
