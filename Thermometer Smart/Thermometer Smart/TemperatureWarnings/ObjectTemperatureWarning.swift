//
//  ObjectTemperatureWarning.swift
//  BabyCare
//
//  Created by HOANDHTB on 10/1/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class ObjectTemperatureWarning: Mappable {
  public var data: DataTemperatureWarning? = nil
    public var status: Int = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
     func mapping(map: Map) {
        data <- map["data"]
        status <- map["status"]
    }
    
    
}
