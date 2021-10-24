//
//  PKRepositoryResponse.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation

// MARK: - BLResponse
struct BLRepositoryListResponse: Decodable {
    let pagelen: Int?
    let values: [PKRepository]?
    let next: String?
}
