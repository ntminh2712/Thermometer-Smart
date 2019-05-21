//
//  ThumbnailEntity.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class ThumbnailEntity: NSObject, Mappable {
    var _default:DefautThumbnailsEntity?
    var medium:MediumThumbnailsEntity?
    var high:HighThumbnailsEntity?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        _default <- map["default"]
        medium <- map["medium"]
        high <- map["high"]
    }
    
}
