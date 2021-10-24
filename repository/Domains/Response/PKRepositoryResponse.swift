//
//  PKRepositoryResponse.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
typealias PKListResponse = PKRespositoryResponse.PKRepositoryList

struct PKRespositoryResponse {
    // MARK: - PKRepositoryList
    struct PKRepositoryList: Decodable {
        let pagelen: Int?
        let values: [PKRepository]?
        let next: String?
    }
}
