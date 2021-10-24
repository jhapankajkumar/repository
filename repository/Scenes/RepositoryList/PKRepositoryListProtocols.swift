//
//  RepositoryListProtocols.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import UIKit

// MARK: View Protocol -
protocol PKRepositoryListViewProtocol: AnyObject {
    init(with viewModel: PKRepositoryListViewModelProtocol)
}

// MARK: ViewModel Protocol-
protocol PKRepositoryListViewModelProtocol: AnyObject {
    var viewDelegate: PKRepositoryListViewModelDelegate? { get set }
    var coordinator: PKRepositoryListCoordinateProtocol? {get set}
    
    //Data Source
    func numberOfRowsAt(section: Int) -> Int
    func dataForRowAt(indexPath: IndexPath) -> PKRepositoryViewDataProtocol?
    
    //Events
    func fetchRepositoryList()
    func didSelectRowAt(indexPath: IndexPath, fromView: PKRepositoryListViewProtocol)
}

// MARK: ViewModel Delegate -
protocol PKRepositoryListViewModelDelegate: AnyObject {
    func viewModelDidFinishWithSuccess()
    func viewModelDidFinishWith(error: PKNetworkError)
}

// MARK: Coordinator Protocol -
protocol PKRepositoryListCoordinateProtocol: AnyObject {
    func didSelectRepository(repository: PKRepository,  from controller: PKRepositoryListViewProtocol)
}
