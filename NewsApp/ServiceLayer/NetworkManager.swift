//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Vidya Mulay on 27/10/24.
//

import Foundation
import Alamofire

// An actor to manage API data fetching and handling

actor NetworkManager: GlobalActor {
    static let shared = NetworkManager()
    private init() {}
    
    private let maxWaitTime = 15.0
    
    func get(request: Configuration) async throws -> Data? {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                request.absoluteURL,
                parameters: request.parameters,
                headers: request.headers,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseString { response in
                switch(response.result) {
                case let .success(value):
                    let mainFields = ResponseHelper.mainFieldsInResponse(value)
                    if let successContent = mainFields.success {
                        continuation.resume(returning: successContent.data(using: .utf8) ?? Data())
                    } else if let _ = mainFields.errorCode.0 {
                        var userInfo: [String : Any]?
                        if let errorMessage = mainFields.errorCode.1 {
                            userInfo = [NSLocalizedDescriptionKey : errorMessage]
                        }
                        let error = NSError(domain: "API_ERROR", code: 401, userInfo: userInfo)
                        
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
