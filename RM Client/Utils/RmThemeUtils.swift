//
//  RmThemeUtils.swift
//  RM Client
//
//  Created by Yazan Tarifi on 31/08/2023.
//

import Foundation
import UIKit

public class RmThemeUtils {
    
    public static let shared = RmThemeUtils()
    
    private init() {}
    
    public func getApplicationPrimaryColor() -> UIColor? {
        return UIColor(named: "PrimaryColor")
    }
}
