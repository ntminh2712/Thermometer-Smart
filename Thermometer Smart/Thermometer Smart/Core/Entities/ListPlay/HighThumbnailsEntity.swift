//
//  HighThumbnailsEntity.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class HighThumbnailsEntity: NSObject, Mappable{
    var url: String?
    var width: Int?
    var height: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        width <- map["width"]
        height <- map["height"]
    }
}
