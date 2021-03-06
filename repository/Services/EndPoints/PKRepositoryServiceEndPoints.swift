//
//  PKRepositoryServiceEndPoints.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import Moya

public enum PKRepositoryServiceEndPoint {
    case repositoryList(nextPageURL: URL?)
}

extension PKRepositoryServiceEndPoint: TargetType {
    public var baseURL: URL {
        switch self {
        case .repositoryList(let nextPageURL):
            if let nextPageURL = nextPageURL {
                return nextPageURL
            } else {
                let baseurl = MicroservicePaths.basePath
                return URL(string: baseurl)!
            }
        }
    }
    
    public var path: String {
        switch self {
        case .repositoryList(let nextPageURL):
            if let _ = nextPageURL {
                return ""
            }
            return MicroservicePaths.repositories
        }
    }
    
    public var method: Moya.Method {
        return Method.get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
