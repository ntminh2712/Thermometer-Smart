//
//  DataTemperatureWarning.swift
//  BabyCare
//
//  Created by HOANDHTB on 10/1/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import ObjectMapper
class DataTemperatureWarning: Mappable {
   public var temperatureWarnings:[TemperatureWarningEntity] = []
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        temperatureWarnings <- map["temperature_warnings"]
    }
    
    
}
