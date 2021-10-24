//
//  PKRepositoryListViewModel.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation

final class PKRepositoryListViewModel {
    weak var viewDelegate: PKRepositoryListViewModelDelegate?
    weak var coordinatorDelegate: PKRepositoryListCoordinateDelegate?
    
    let repositoryService: PKRepositoryServiceProtocol
    
    var currentPageNuber: Int = 0
    
    var repoList:[PKRepository] = []
    
    var nextSetURL: String?
    
    var cellViewModels: [PKRepositoryListViewData] = []
    
    init(service: PKRepositoryServiceProtocol) {
        self.repositoryService = service
    }
    
    private func handleSuccess() {}
    
    private func handleFailure(error: PKNetworkError) {}
    
}

extension PKRepositoryListViewModel : PKRepositoryListViewModelProtocol {
    
    func fetchRepositoryList() {}
    
    func numberOfRowsAt(section: Int) -> Int {
        return 1
    }
    
    func dataForRowAt(indexPath: IndexPath) -> PKRepositoryViewDataProtocol? {
        return nil
    }
    
    func didSelectRowAt(indexPath: IndexPath, fromView: PKRepositoryListViewProtocol) {}
}

