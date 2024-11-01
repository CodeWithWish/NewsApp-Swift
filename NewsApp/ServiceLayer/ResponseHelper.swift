//
//  ResponseHelper.swift
//  NewsApp
//
//  Created by Vidya Mulay on 31/10/24.
//

import Foundation

// A helper class to parse the response to check if the response has errors or the success data as expected.
class ResponseHelper {
    static func mainFieldsInResponse(_ stringResponse: String) -> (success: String?, errorCode: (String?, String?)) {
        
        guard let jsonResponse = stringResponse.toJSON() as? [String: Any?] else {
            return (success: nil, errorCode: ("500", nil))
        }
        
        var success: String?
        var errorCode: (String?, String?)
        
        if jsonResponse["status"] as! String == "ok" {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResponse, options: [])
                success = String(data: jsonData, encoding: .utf8)!
            } catch let error {
                print("\(error.localizedDescription)")
            }
        } else {
            // Response has error
            let code = jsonResponse["code"] as? String ?? "0"
            errorCode = (code, jsonResponse["message"] as? String ?? "Unknown error")
        }
        return (success: success,  errorCode: errorCode)
    }
}
