//
//  NetworkError.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation

public enum NetworkError: Error {
    // 400 Client Error
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    // 500 Server Error
    case internalServerError
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case unknown
    case incorrectDataReturned
    public var message: String {
        switch self {
        case .badRequest:
            return "Incorrect JSON format"
        case .unauthorized:
            return "Un Authorized"
        case .forbidden:
            return "Forbidden Access"
        case .notFound:
            return "Connection lost"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeout:
            return "Gateway Timeout"
        case .incorrectDataReturned:
            return "Incorrect Data response"
        default:
            return "Unknown error"
        }
    }
}

public struct ErrorResponse: Codable, Error {
    public let code: String
    public let title: String
    public let message: String
    
    public init(code: String, title: String, message: String) {
        self.code = code
        self.title = title
        self.message = message
    }
}

public enum HTTPStatusCode: Int {
    
    // 200 Success
    case success = 200
    // 400 Client Error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    // 500 Server Error
    case internalServerError = 500
    case badGateway = 501
    case serviceUnavailable = 502
    case gatewayTimeout = 503
    
    var networkError: NetworkError {
        switch self {
        case .success:
            return NetworkError.unknown
        case .badRequest:
            return NetworkError.badRequest
        case .unauthorized:
            return NetworkError.unauthorized
        case .forbidden:
            return NetworkError.forbidden
        case .notFound:
            return NetworkError.notFound
        case .internalServerError:
            return NetworkError.internalServerError
        case .badGateway:
            return NetworkError.badGateway
        case .serviceUnavailable:
            return NetworkError.serviceUnavailable
        case .gatewayTimeout:
            return NetworkError.gatewayTimeout
        }
    }
}
