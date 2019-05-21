//
//  ItemPlayList.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class ItemPlayList: NSObject, Mappable {
    var kind: String?
    var etag: String?
    var id: IdItemListPlay?
    var snippet:SnippetItemListPlayEntity?
    var track:Int = 0
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
