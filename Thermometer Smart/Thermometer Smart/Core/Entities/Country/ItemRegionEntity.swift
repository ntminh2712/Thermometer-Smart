//
//  ItemRegionEntity.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit
import ObjectMapper
class ItemRegionEntity: Mappable {
    var kind: String?
    var etag: String?
    var id: String?
    var snippet: SnippetRegionEntity?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        id <- map["id"]
        snippet <- map["snippet"]
    }
}
