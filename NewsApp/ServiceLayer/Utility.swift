//
//  Utility.swift
//  NewsApp
//
//  Created by Vidya Mulay on 30/10/24.
//

import Foundation
import SwiftUI

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

extension URL: Identifiable {
    public var id: URL { return self }
}

extension String: Identifiable {
    public var id: String { return self }
}
