//
//  TSAPI.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation


import UIKit
import Moya
import RxSwift
extension TSAPI:TargetType
{
    var baseURL: URL {
        return URL(string: Config.rootUrl)!
    }
    
    var path: String {
        switch self {
        case .i18nRegions:
            return "/i18nRegions"
        case .searchPlayList:
            return "/search"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .i18nRegions, .searchPlayList:
            return .get
        default:
            return .get
        }
    }
    
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .i18nRegions, .searchPlayList:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    
    var sampleData: Data {
        switch self {
        default:
            guard let url = Bundle.main.url(forResource: "Demo", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    public var parameters: [String : Any]? {
        switch self {
        case .i18nRegions(let part, let hl):
            var paramester: [String: Any]?{
                var parameter:[String:Any] = [:]
                parameter["part"] = part
                parameter["hl"] = hl
                parameter["key"] = Config.Key
                return parameter
            }
            return paramester
        case .searchPlayList(let type, let q, let maxResulst, let part, let regionCode, let pageToken):
            var paramester: [String: Any]?{
                var paramester: [String: Any] = [:]
                paramester["type"] = type
                paramester["q"] = q
                paramester["maxResulst"] = maxResulst
                paramester["part"] = part
                paramester["regionCode"] = regionCode
                paramester["pageToken"] = pageToken
                paramester["key"] = Config.Key
                return paramester
            }
            return paramester
        default:
            return nil
        }
    }
    var task: Moya.Task {
        return .requestParameters(parameters: self.parameters! , encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
    
}

