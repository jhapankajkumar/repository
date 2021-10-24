//
//  VIewController+Extensions.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    @discardableResult
    func showAlert(with title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        alert.view.tintColor = .systemBlue
        present(alert, animated: true, completion: nil)
        return alert
    }
}

extension UINavigationController {
    static func custom() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.view.tintColor = .green
        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
}
