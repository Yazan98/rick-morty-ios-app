//
//  RmPermissionsManager.swift
//  RM Client
//
//  Created by Yazan Tarifi on 02/09/2023.
//

import Foundation
import UserNotifications
import AVFoundation
import Photos

public final class RmPermissionsManager {
    
    public static let shared: RmPermissionsManager = RmPermissionsManager()
    
    private init() {}
    
    public func isNotificationsPermissionEnabled() -> Bool {
        var status: Bool = false
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                status = false
            } else if settings.authorizationStatus == .denied {
                status = false
            } else if settings.authorizationStatus == .authorized {
                status = true
            }
        })
        return status
    }
    
    public func isStoragePermissionEnabled() -> Bool {
        var status: Bool = false
        let photosStatus = PHPhotoLibrary.authorizationStatus()
        if photosStatus == .authorized {
            status = true
        } else {
            status = false
        }
        return status
    }
    
}
