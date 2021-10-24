//
//  NetworkService.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import Moya

final public class PKNetworkService {
    static let shared = PKNetworkService()
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

extension PKNetworkService {
    public func requestObject<T: TargetType, C: Decodable>(_ target: T, c classType: C.Type, completion: @escaping (Result<C, PKNetworkError>) -> Void) {
        provider.request(MultiTarget(target)) { (result) in
            switch result {
            case .success(let value):
                do {
                    let filteredResponse = try value.filterSuccessfulStatusCodes()
                    let result = try filteredResponse.map(C.self)
                    completion(.success(result))
                } catch is DecodingError {
                    completion(.failure(PKNetworkError.incorrectDataReturned))
                } catch MoyaError.statusCode(let response) {
                    if let code = PKHTTPStatusCode(rawValue: response.statusCode) {
                        completion(.failure(code.networkError))
                    } else {
                        completion(.failure(PKNetworkError.unknown))
                    }
                }
                catch {
                    completion(.failure(PKNetworkError.unknown))
                }
            case .failure:
                completion(.failure(PKNetworkError.unknown))
            }
        }
    }
}
