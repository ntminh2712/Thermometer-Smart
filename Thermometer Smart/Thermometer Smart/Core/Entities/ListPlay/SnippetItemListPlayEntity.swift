//
//  SnippetItemListPlayEntity.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class SnippetItemListPlayEntity: NSObject, Mappable{
    var publishedAt: String?
    var channelId: String?
    var title:String?
    var _description:String?
    var channelTitle: String?
    var liveBroadcastContent: String?
    var thumbnails: ThumbnailEntity?
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        publishedAt <- map["publishedAt"]
        channelId <- map["channelId"]
        title <- map["title"]
        _description <- map["description"]
        thumbnails <- map["thumbnails"]
        channelTitle <- map["channelTitle"]
        liveBroadcastContent <- map["liveBroadcastContent"]
    }
}
