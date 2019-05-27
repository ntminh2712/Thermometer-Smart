//
//  Array+Extension.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation
import Moya

extension Array where Element == MultipartFormData {
    
    func appendParameters(_ parameters: [String:Any]?) -> [MultipartFormData] {
        var formData = self
        if let parameters = parameters {
            parameters
                .flatMap { key, value in multipartQueryComponents(key, value) }
                .forEach { key, value in
                    if let data = value.data(using: .utf8, allowLossyConversion: false) {
                        formData.append(MultipartFormData.init(provider: .data(data), name: key))
                    }
            }
        }
        return formData
    }
    
    /// Encode parameters for multipart/form-data
    private func multipartQueryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += multipartQueryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += multipartQueryComponents("\(key)[]", value)
            }
        } else {
            components.append((key, "\(value)"))
        }
        
        return components
    }
}


