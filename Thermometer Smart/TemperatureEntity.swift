//
//  TemperatureEntity.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation

import RealmSwift
import ObjectMapper
class TemperatureEntity: Object, Mappable {
    @objc dynamic var id:String = ""
    @objc dynamic var value: Double = 0.0
    @objc dynamic var date:Date = Date()
    var deviceTime: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        value <- map["value"]
        deviceTime <- map["device_time"]
    }
}
