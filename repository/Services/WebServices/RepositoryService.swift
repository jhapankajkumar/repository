//
//  RepositoryService.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import Moya

protocol PKRepositoryServiceProtocol: AnyObject {
    func fetchRepositoryList( _ completion: @escaping (_ response: PKListResponse?, _ error: PKNetworkError?) -> Void)
}

final class PKRespositoryService: PKRepositoryServiceProtocol {
    let networkService: PKNetworkService
    init(networkService: PKNetworkService = PKNetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchRepositoryList( _ completion: @escaping (_ response: PKListResponse?, _ error: PKNetworkError?) -> Void) {
        
        networkService.requestObject(PKRepositoryServiceEndPoint.repositoryList, c: PKListResponse.self) {
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
