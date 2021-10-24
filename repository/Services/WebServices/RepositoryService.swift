//
//  RepositoryService.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import Moya

protocol PKRepositoryServiceProtocol: AnyObject {
    func fetchRepositoryList(url: String?, _ completion: @escaping (_ response: PKListResponse?, _ error: PKNetworkError?) -> Void)
}

final class PKRepositoryService: PKRepositoryServiceProtocol {
    let networkService: PKNetworkService
    init(networkService: PKNetworkService = PKNetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchRepositoryList(url: String?, _ completion: @escaping (_ response: PKListResponse?, _ error: PKNetworkError?) -> Void) {
        let nxtURL: URL? = URL(string: url ?? "")
        networkService.requestObject(PKRepositoryServiceEndPoint.repositoryList(nextPageURL: nxtURL), c: PKListResponse.self) {
            (result) in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
