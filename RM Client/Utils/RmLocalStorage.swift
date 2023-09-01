//
//  RmLocalStorage.swift
//  RM Client
//
//  Created by Yazan Tarifi on 31/08/2023.
//

import Foundation

final class RmLocalStorage {
    
    private let USER_ID_SESSION_KEY = "UserIdSession"
    private let LAST_HOME_SELECTED_TAB = "LastHomeSelectedTab"
    private let IS_FIRST_TIME_APP_RUN = "IsFirstTimeAppRun"
    private let IS_USER_LOGGED_IN = "IsUserLoggedIn"
    
    static let shared = RmLocalStorage()
    
    private init() {}
    
    public func getUserIdSession() -> String {
        return UserDefaults.standard.string(forKey: USER_ID_SESSION_KEY) ?? ""
    }
    
    public func getLastHomeSelectedTabIndex() -> Int {
        return UserDefaults.standard.integer(forKey: LAST_HOME_SELECTED_TAB)
    }
    
    public func isFirstTimeAppOpened() -> Bool {
        return !UserDefaults.standard.bool(forKey: IS_FIRST_TIME_APP_RUN)
    }
    
    public func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: IS_USER_LOGGED_IN)
    }
    
    public func onUpdateAppOpeningStatus(newStatus: Bool) {
        UserDefaults.standard.set(newStatus, forKey: IS_FIRST_TIME_APP_RUN)
    }
    
    public func onUpdateUserLoggedInStatus(newStatus: Bool) {
        UserDefaults.standard.set(newStatus, forKey: IS_USER_LOGGED_IN)
    }
    
    public func onUpdateHomeLastSelectedTabIndex(newIndex: Int) {
        UserDefaults.standard.set(newIndex, forKey: LAST_HOME_SELECTED_TAB)
    }
    
}
