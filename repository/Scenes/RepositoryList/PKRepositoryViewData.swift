//
//  RepositoryViewData.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation

protocol PKRepositoryViewDataProtocol {
    var avatarURL: String? {get}
    var createdDate: String? {get}
    var name: String? {get}
    var type: String? {get}
    var uuid: String? {get}
}

struct PKBLRepositoryListViewData {
    let repository: PKRepository
    
    init(repository: PKRepository) {
        self.repository = repository
    }
}

extension PKBLRepositoryListViewData: PKRepositoryViewDataProtocol {
    var avatarURL: String? {
        return repository.owner?.links?.avatar?.href
    }
    var createdDate: String? {
        let date = repository.createdOn
        return date
    }
    
    var name: String? {
        return repository.name
    }
    
    var type: String? {
        return repository.owner?.type
    }
    
    var uuid: String? {
        return repository.uuid
    }
}
