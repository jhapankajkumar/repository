//
//  VIewController+Extensions.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import UIKit

extension UINavigationController {
    static func custom() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.view.tintColor = .green
        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
}
