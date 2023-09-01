//
//  Utils.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation
import MaterialComponents.MaterialSnackbar

public class Utils {
    
    static func showMessage(errorMessage: String) {
        let action = MDCSnackbarMessageAction()
        let message = MDCSnackbarMessage()
        message.text = errorMessage
        MDCSnackbarManager.default.show(message)
       }
    
}

extension String {
    func getLocalizedString() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
