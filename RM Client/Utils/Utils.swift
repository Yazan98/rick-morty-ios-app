//
//  Utils.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation

extension String {
    func getLocalizedString() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
