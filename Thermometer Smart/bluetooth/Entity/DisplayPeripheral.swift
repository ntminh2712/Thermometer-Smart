//
//  DisplayPeripheral.swift
//  Thermometer Smart
//
//  Created by nava on 9/4/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation
import CoreBluetooth

struct DisplayPeripheral {
    var name:String
    var lastRSSI:NSNumber
    var peripheral:CBPeripheral
    var advertisementData: [String : Any]
    var macAddress: String
}
