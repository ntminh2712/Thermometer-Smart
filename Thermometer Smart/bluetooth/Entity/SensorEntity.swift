//
//  SensorEntity.swift
//  BabyCare
//
//  Created by HOANPV on 9/27/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import CoreBluetooth
class SensorEntity: NSObject {
    var peripheral: CBPeripheral!
    var characteristic: CBCharacteristic!
}
