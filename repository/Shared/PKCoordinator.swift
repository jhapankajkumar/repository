//
//  PKCoordinator.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
protocol PKCoordinator: AnyObject {
    var childCoordinators: [PKCoordinator] { get }
    func start()
    func addChildCoordinator(_ coordinator: PKCoordinator)
    func removeChildCoordinator(_ coordinator: PKCoordinator)
}

