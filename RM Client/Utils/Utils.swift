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

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
