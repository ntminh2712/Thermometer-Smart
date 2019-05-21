//
//  PageInfoListPlay.swift
//  YouTubeFoxMusic
//
//  Created by nava on 7/24/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class PageInfoListPlay: NSObject, Mappable{
  
    var totalResults:Int?
    var resultsPerPage: Int?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        totalResults <- map["totalResults"]
        resultsPerPage <- map["resultsPerPage"]
    }
    
}
