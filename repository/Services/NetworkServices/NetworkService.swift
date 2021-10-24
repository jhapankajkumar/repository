//
//  NetworkService.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import Moya

final public class NetworkService {
    static let shared = NetworkService()
    fileprivate let provider: MoyaProvider<MultiTarget>
    
    private init() {
        let urlSessionConfig = URLSessionConfiguration.default
        let apiConnectTimeout: Double = 90.0
        urlSessionConfig.timeoutIntervalForRequest =  apiConnectTimeout
        
        let manager = Session(
            configuration: urlSessionConfig
        )
        
        self.provider = MoyaProvider<MultiTarget>( requestClosure: { (endpoint, closure) in
            guard let request = try? endpoint.urlRequest() else { return }
            closure(.success(request))
        }, session: manager)
    }
}
