//
//  ThermometerRate.swift
//  BabyCare
//
//  Created by nava on 9/4/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation
import CoreBluetooth
struct ThermometerRate {
    let intensity:Int?
    let temperature: Int
    let characteristic: CBCharacteristic?
    let peripheral: CBPeripheral?
    let device: DeviceEntity?
}
