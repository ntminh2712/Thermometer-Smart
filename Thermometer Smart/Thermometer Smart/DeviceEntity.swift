//
//  DeviceEntity.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
class DeviceEntity: Object, Mappable {
    @objc dynamic var macAddress: String = ""
    @objc dynamic var uuid: String = ""
    @objc dynamic var minThermoter: Double = 35
    @objc dynamic var maxThermoter: Double = 38
    @objc dynamic var status:Int = 0
    @objc dynamic var temperature: Double = 0.0
    //đã đến nhiệt độ cảnh báo
    @objc dynamic var isWarning: Bool = false
    //Đã show dialog warning để xếp hàng chờ show cho lần sau
    @objc dynamic var showWarning: Int = 0
    
    @objc dynamic var isDisconnect: Bool = false
    
    @objc dynamic var dateLoss:Date = Date()
    //Là thiết bị được kết nối tới
    @objc dynamic var isConnect: Bool = false
    
    //Thiết lập lúc đầu auto connect
    @objc dynamic var isAutoConnect: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        macAddress <- map["mac_address"]
        uuid <- map["uiid"]
    }
    
}
extension DeviceEntity
{
}
