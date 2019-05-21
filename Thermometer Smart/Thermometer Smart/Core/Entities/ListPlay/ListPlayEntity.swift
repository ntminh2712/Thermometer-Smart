//
//  ListPlayEntity.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class ListPlayEntity: NSObject, Mappable {
    var kind:String?
    var etag:String?
    var nextPageToken:String?
    var regionCode:String?
    var pageInfo: PageInfoListPlay?
    var  items :[ItemPlayList] = []
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        nextPageToken <- map["nextPageToken"]
        regionCode <- map["regionCode"]
        pageInfo <- map["pageInfo"]
        items <- map["items"]
    }
    
}
