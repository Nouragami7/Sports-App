//
//  AlertUtils.swift
//  Sports-App
//
//  Created by macOS on 04/06/2025.
//

import Foundation
import UIKit

struct AlertUtils {
    static func showInfoAlert(on viewController: UIViewController,
                              title: String,
                              message: String,
                              buttonTitle: String = "OK") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        viewController.present(alert, animated: true)
    }

    static func showConfirmationAlert(on viewController: UIViewController,
                                      title: String,
                                      message: String,
                                      confirmTitle: String = "Delete",
                                      cancelTitle: String = "Cancel",
                                      confirmHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        
        alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: { _ in
            confirmHandler()
        }))
        
        viewController.present(alert, animated: true)
    }
}
