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
        let service: PKRepositoryServiceProtocol = PKRespositoryService()
        let viewModel: PKRepositoryListViewModelProtocol = PKRepositoryListViewModel(service: service)
        
        let view: UIViewController & PKRepositoryListViewProtocol & PKRepositoryListViewModelDelegate = PKRepositoryListViewController(with: viewModel)
        viewModel.viewDelegate = view
        viewModel.coordinatorDelegate = self
        self.navigationController.setViewControllers([view], animated: true)
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
    func didSelectRepository(repository: PKRepository, from controller: PKRepositoryListViewProtocol) {
       
    }
}
