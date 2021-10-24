//
//  PKRepositoryListCoordinator.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import UIKit
final class PKRepositoryListCoordinator: PKCoordinator {
    
    var childCoordinators: [PKCoordinator] = []
    let navigationController: UINavigationController
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
    
    func addChildCoordinator(_ coordinator: PKCoordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: PKCoordinator) {
        if let index = (childCoordinators.firstIndex(where: { $0 === coordinator })) {
            childCoordinators.remove(at: index)
        }
    }
}

extension PKRepositoryListCoordinator: PKRepositoryListCoordinateDelegate {
    func didSelectRepository(repository: PKRepository, from controller: UIViewController) {
       
    }
}
