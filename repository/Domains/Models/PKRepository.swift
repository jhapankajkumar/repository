//
//  PKRepository.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation

import Foundation
// MARK: - Value
struct PKRepository: Decodable {
    let fullName, name: String?
    let language, createdOn: String?
    let owner: Owner?
    let uuid: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case name,language
        case createdOn = "created_on"
        case owner
        case uuid
    }
}



// MARK: - ValueLinks
struct RepositoryLinks: Decodable {
    let watchers,avatar: Avatar?

    enum CodingKeys: String, CodingKey {
        case watchers, avatar
    }
}

// MARK: - Avatar
struct Avatar: Decodable {
    let href: String?
}

// MARK: - Owner
struct Owner: Decodable {
    let username, displayName, type, uuid: String?
    let links: OwnerLinks?

    enum CodingKeys: String, CodingKey {
        case username
        case displayName = "display_name"
        case type, uuid, links
    }
}

// MARK: - OwnerLinks
struct OwnerLinks: Decodable {
    let linksSelf, html, avatar: Avatar?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, avatar
    }
}

