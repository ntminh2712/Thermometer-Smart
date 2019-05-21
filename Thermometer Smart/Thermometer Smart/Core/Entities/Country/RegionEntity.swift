//
//  RegionEntity.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//


import UIKit
import ObjectMapper
class RegionEntity: Mappable {
    var kind:String?
    var etag:String?
    var items:[ItemRegionEntity]  = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        items <- map["items"]
    }
    
}

