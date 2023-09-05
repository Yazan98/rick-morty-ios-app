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
    
    public func isNotificationsPermissionEnabled(onComplete: @escaping (Bool) -> Void) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                onComplete(false)
            } else if settings.authorizationStatus == .denied {
                onComplete(false)
            } else if settings.authorizationStatus == .authorized {
                onComplete(true)
            }
        })
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
    
    public func onRequestNotificationsPermission(onComplete: @escaping () -> Void) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
                if let error = error {
                        print("Request Authorization Failed (\(error), \(error.localizedDescription))")
                } else {
                    onComplete()
                }
            }
    }
    
    public func onRequestGalleryAccess(onComplete: @escaping () -> Void) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    onComplete()
                } else {

                }
        }
    }
    
}
