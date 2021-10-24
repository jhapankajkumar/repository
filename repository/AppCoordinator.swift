//
//  AppCoordinator.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    func start() {
        let navigationController: UINavigationController = .custom()
        let repositoryListCoordinator = PKRepositoryListCoordinator(with: navigationController)
        repositoryListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
