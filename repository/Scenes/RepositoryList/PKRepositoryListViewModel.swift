//
//  PKRepositoryListViewModel.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation

final class PKRepositoryListViewModel {
    weak var viewDelegate: PKRepositoryListViewModelDelegate?
    var coordinator: PKRepositoryListCoordinateProtocol?
    
    let repositoryService: PKRepositoryServiceProtocol
    
    var currentPageNuber: Int = 0
    
    var repoList:[PKRepository] = []
    
    var nextSetURL: String?
    
    var cellViewModels: [PKRepositoryListViewData] = []
    
    init(service: PKRepositoryServiceProtocol) {
        self.repositoryService = service
    }
    
    private func handleSuccess() {
        if let delegate = viewDelegate {
            delegate.viewModelDidFinishWithSuccess()
        }
    }
    
    private func handleFailure(error: PKNetworkError) {
        if let delegate = viewDelegate {
            delegate.viewModelDidFinishWith(error: error)
        }
    }
}

extension PKRepositoryListViewModel : PKRepositoryListViewModelProtocol {
    
    func fetchRepositoryList() {
        repositoryService.fetchRepositoryList(url: nextSetURL) { [weak self] (response, error) in
            if let error = error {
                self?.handleFailure(error: error)
            } else if let response = response {
                self?.nextSetURL = response.next
                if let list = response.values {
                    if self?.repoList.count ?? 0 > 0 {
                        self?.repoList.append(contentsOf: list)
                    } else {
                        self?.repoList = list
                    }
                    
                    self?.cellViewModels = self?.repoList.map({ repo in
                        return PKRepositoryListViewData(repository: repo)
                    }) ?? []
                }
                self?.handleSuccess()
            }
        }
    }
    
    func numberOfRowsAt(section: Int) -> Int {
        return cellViewModels.count
    }
    
    func dataForRowAt(indexPath: IndexPath) -> PKRepositoryViewDataProtocol? {
        if indexPath.row < cellViewModels.count {
            return cellViewModels[indexPath.row]
        }
        return nil
    }
    
    func didSelectRowAt(indexPath: IndexPath, fromView: PKRepositoryListViewProtocol) {
        if indexPath.row < cellViewModels.count {
            let viewModel = cellViewModels[indexPath.row]
            let repository = self.repoList.first { repo in
                return repo.uuid == viewModel.uuid
            }
            if let coordinatorDelegate = coordinator,
               let repository = repository {
                coordinatorDelegate.didSelectRepository(repository: repository, from: fromView)
            }
        }
    }
}

