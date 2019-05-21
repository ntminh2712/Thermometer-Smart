//
//  IdItemListPlay.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class IdItemListPlay: NSObject, Mappable {
    var kind:String?
    var playlistId:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        playlistId <- map["playlistId"]
    }
}
