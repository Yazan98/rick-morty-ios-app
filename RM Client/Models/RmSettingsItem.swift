//
//  RmSettingsItem.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import Foundation

public struct RmSettingsItem: Codable, Identifiable {
    public var id: String
    public var icon: String
    public var backgroundColor: String
    public var name: String
    public var description: String
    
    public static let shared: [RmSettingsItem] = [
        RmSettingsItem(
            id: "theme",
            icon: "moon.fill",
            backgroundColor: "#000000",
            name: "theme".getLocalizedString(),
            description: ""
        ),
        RmSettingsItem(
            id: "language",
            icon: "switch.2",
            backgroundColor: "#0CA6F2",
            name: "language".getLocalizedString(),
            description: "Change Your Application Language"
        ),
        RmSettingsItem(
            id: "developer_link",
            icon: "person.fill",
            backgroundColor: "#00F9C6",
            name: "developer_link".getLocalizedString(),
            description: ""
        )
    ]
}
