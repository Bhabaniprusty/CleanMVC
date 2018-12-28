//
//  ServiceError.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case invalidURL(String)
    case invalidArguments
    case invalidResponse
    case unknownResponse
    case backendError(String)
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        get {
            switch self {
            case .invalidArguments:
                return "Failed due to invalid arguments"
            case .invalidResponse:
                return "Error due to invalid response"
            case .backendError(let message):
                return message
            case .unknownResponse:
                return "Unknown error. Please check your network."
            case .invalidURL(let url):
                return "Invalid Url \(url)"
            }
        }
    }
}

extension Error {
    var isCancelled: Bool {
        return (self as NSError?)?.code == NSURLErrorCancelled
    }
}
