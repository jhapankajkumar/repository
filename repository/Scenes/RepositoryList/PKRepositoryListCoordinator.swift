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
    weak var viewModel: PKRepositoryListViewModelProtocol?
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service: PKRepositoryServiceProtocol = PKRespositoryService()
        let viewModel: PKRepositoryListViewModelProtocol = PKRepositoryListViewModel(service: service)
        viewModel.coordinator = self
        
        let view: UIViewController & PKRepositoryListViewProtocol & PKRepositoryListViewModelDelegate = PKRepositoryListViewController(with: viewModel)
        viewModel.viewDelegate = view
        
        self.viewModel = viewModel
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

extension PKRepositoryListCoordinator: PKRepositoryListCoordinateProtocol {
    func didSelectRepository(repository: PKRepository, from controller: PKRepositoryListViewProtocol) {
        if let _ = controller as? UIViewController {
            print("Move to next screen")
            // Move to next screen
        }
    }
}
