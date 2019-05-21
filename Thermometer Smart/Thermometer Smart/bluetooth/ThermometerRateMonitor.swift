
//
 //  MainViewController.swift
 //  HRM
 //
 //  Created by Sebastiao Gazolla Costa Junior on 04/01/17.
 //  Copyright © 2017 Sebastiao Gazolla Costa Junior. All rights reserved.
 //
 
 import UIKit
 import CoreBluetooth
 import RxSwift
protocol ThermometerTemperatureMonitorProtocol {
    func getDataThermometer(data: ThermometerRate)
}
class ThermometerTemperatureMonitor: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    let BLE_HEART_RATE_MEASUREMENT_CHARACTERISTIC_CBUUID = CBUUID(string:  "00002A1C-0000-1000-8000-00805f9b34fb")
    let BATTERY_LEVEL_CHARACTERISTIC = CBUUID(string: "00002A19-0000-1000-8000-00805f9b34fb")
    let CLIENT_CHARACTERISTIC_CONFIG_DESCRIPTOR_UUID = CBUUID(string: "00002902-0000-1000-8000-00805f9b34fb")
    let STORED_PERIPHERAL_IDENTIFIER = "STORED_PERIPHERAL_IDENTIFIER"
    var listSensor: [SensorEntity] = []
    private enum BlueToothGATTServices: UInt16 {
        case BatteryService    = 0x180F
        case DeviceInformation = 0x180A
        case HeartRate         = 0x1809
        
        var UUID: CBUUID {
            return CBUUID(string: String(self.rawValue, radix: 16, uppercase: true))
        }
    }
    
    var centralManager: CBCentralManager!
    var heartMonitor: CBPeripheral?
    var heartMonitorList:[DisplayPeripheral]?
    var birthday: Date?
    private var isScanning = false
    
    var mHTCharacteristic:CBCharacteristic? = nil
    var mRXCharacteristic: CBCharacteristic? = nil
    var mVersionCharacteristic: CBCharacteristic? = nil
    var mBatteryCharacteritsic: CBCharacteristic? = nil
   
    
    var update: ((_ hr:ThermometerRate)->())?
    var updateMessage: ((_ msg:String)->())?
    var updateList: ((_ list:[DisplayPeripheral])->())?
    var updateStopScan: (()->())?
    var poweredOff:(()->())?
    var close:(()->())?
    var interuptWarning:(()->())?
    var delegrate:ThermometerTemperatureMonitorProtocol?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.global())
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(">>>>>>>>> centralManagerDidUpdateState")
        
        if #available(iOS 10.0, *) {
            switch central.state {
                
            case CBManagerState.poweredOff:
                break
                
            case CBManagerState.poweredOn:
                NSLog("CoreBluetooth BLE hardware is powered on and ready");
                self.updateMessage?("Bluetooth ligado")
                startScanning()
            case CBManagerState.unauthorized:
                NSLog("CoreBluetooth BLE hardware is unauthorized");
                
            case CBManagerState.resetting:
                NSLog("CoreBluetooth BLE hardware is resetting");
                
            case CBManagerState.unknown:
                NSLog("CoreBluetooth BLE hardware is unknown");
                
            case CBManagerState.unsupported:
                NSLog("CoreBluetooth BLE hardware is unsupported");
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(">>>>>>>>> didConnect peripheral")
        print(">>>>>>>>> peripheral uuid =>> \(peripheral.identifier.uuidString)")
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(peripheral.identifier.uuidString, forKey: STORED_PERIPHERAL_IDENTIFIER)
        userDefaults.synchronize()
        
        self.heartMonitor = peripheral
        self.heartMonitor!.delegate = self
        self.heartMonitor!.discoverServices(nil)
        let connected = "Connected: " + (self.heartMonitor!.state == CBPeripheralState.connected ? "YES" : "NO")
        print("\(connected)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        
        heartMonitor = peripheral
        
        print(">>>>>>>>> didDiscover peripheral")
        for (index, foundPeripheral) in heartMonitorList!.enumerated(){
            if foundPeripheral.peripheral.identifier == peripheral.identifier{
                heartMonitorList![index].lastRSSI = RSSI
                return
            }
        }
        
        let sensorName:String
        if let localName:String = advertisementData[CBAdvertisementDataLocalNameKey] as! String? {
            sensorName = localName
        } else if let localName:String = peripheral.name{
            sensorName = localName
        } else {
            sensorName = "No Device Name"
        }
        
        if advertisementData.count >= 4
        {
            if let kCBAdvDataServiceUUIDs = advertisementData["kCBAdvDataServiceUUIDs"] as? Any
            {
                let arr = kCBAdvDataServiceUUIDs as? NSArray
                let kCBAdvDataManufacturerData = advertisementData["kCBAdvDataManufacturerData"] as? Any
                let arrMac = Array(kCBAdvDataManufacturerData.debugDescription.replacingOccurrences(of: "Optional(Optional(<", with: "").replacingOccurrences(of: ">))", with: "").replacingOccurrences(of: " ", with: ""))
                var i:Int = 0;
                var strMac = ""
                for character in arrMac
                {
                    strMac +=  String(character)
                    i += 1
                    if i%2 == 0 && i != arrMac.count
                    {
                        strMac +=  "-"
                    }
                    
                }
                let name = arr![0] as? Any
                if name.debugDescription.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "") == "Health Thermometer"
                {
                    let displayPeripheral:DisplayPeripheral = DisplayPeripheral(name: sensorName, lastRSSI: RSSI, peripheral: peripheral, advertisementData: advertisementData, macAddress: strMac)
                    heartMonitorList!.append(displayPeripheral)
                    self.updateList?(self.heartMonitorList!)
                }
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if error != nil { print(" didDisconnectPeripheral:: \(error!)") }
        self.heartMonitor?.delegate = nil
        self.updateMessage?("Desconnected.")
        
        if heartMonitor != nil
        {
            
            return
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil { print(" didDiscoverServices:: \(error!)") }
        
        for service in peripheral.services!
        {
            print("Discovered service: \(service.uuid)")
            peripheral.discoverCharacteristics(nil, for: service )
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil { print(" didDiscoverCharacteristicsFor:: \(error!)") }
        for characteristic in service.characteristics! {
            print(characteristic)
            
            if characteristic.uuid == BATTERY_LEVEL_CHARACTERISTIC {
                
                peripheral.readValue(for: characteristic)
                self.mBatteryCharacteritsic = characteristic
                
            }else
                
                if characteristic.uuid == BLE_HEART_RATE_MEASUREMENT_CHARACTERISTIC_CBUUID {
                    self.mHTCharacteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                    
                }
                else if characteristic.uuid.uuidString == "0002"
                {
                    let sensor: SensorEntity = SensorEntity()
                    sensor.characteristic = characteristic
                    sensor.peripheral = peripheral
                    self.listSensor.append(sensor)
                    var data = "1".data(using: .utf8)
                    
                    peripheral.writeValue(data!, for: characteristic, type: CBCharacteristicWriteType.withResponse)
            }
            
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil { print(" didUpdateValueFor:: \(error!)") }
        if characteristic.uuid == CBUUID(string: "00002A1C-0000-1000-8000-00805f9b34fb") {
            self.getHeartBPMData(characteristic: characteristic, error: error, peripheral: peripheral)
        }
    }

    
    
    func connectUIID(uiid: String)
    {
        DispatchQueue.main.async {
            self.updateMessage?("Retrieving sensor...")
            if !uiid.isEmpty
            {
                for p:AnyObject in self.centralManager.retrievePeripherals(withIdentifiers: [NSUUID(uuidString:uiid)! as UUID]) {
                    if p is CBPeripheral {
                        self.heartMonitor = p as? CBPeripheral
                        self.centralManager.connect(self.heartMonitor!, options: nil)
                        print(">>>>>>>>> connecting Peripheral....")
                        self.updateMessage?("Connecting sensor...")
                        return
                    }
                }
            }
        }
        
    }
    func startScanning(){
        //    self.updateMessage?("Procurando periféricos...")
        print(">>>>>>>>> startScanning")
        if centralManager == nil {
            return;
        }
        if centralManager.state == .poweredOff
        {
            self.poweredOff?()
        }
        self.heartMonitorList = []
       self.updateList?(self.heartMonitorList!)
        self.isScanning = true
        let services = [
            BlueToothGATTServices.DeviceInformation.UUID,
            BlueToothGATTServices.HeartRate.UUID,
            BlueToothGATTServices.BatteryService.UUID
        ]
        self.centralManager.scanForPeripherals(withServices:services, options: nil)
        NSLog("Services: \(services.description)")
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 20)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            if self.isScanning
            {
                self.stopScanning()
            }
        })
    }
    
    public func stopScanning() {
        print(">>>>>>>>> stopScanning")
        if (self.isScanning) {
            self.isScanning = false
            self.centralManager.stopScan()
            self.updateStopScan?()
        }
    }
    
    public func sendDisplayCercius()
    {
        for item in listSensor
        {
            let data = "1".data(using: .utf8)
            item.peripheral.writeValue(data!, for: item.characteristic, type: CBCharacteristicWriteType.withResponse)
        }
    }
    
    public func sendDisplayF()
    {
        for item in listSensor
        {
            let data = "0".data(using: .utf8)
            item.peripheral.writeValue(data!, for: item.characteristic, type: CBCharacteristicWriteType.withResponse)
        }
    }
    
    public func registerPeripheral(peripheral:CBPeripheral){
        
    }
    
    public func removePeripheral() {
        print(">>>>>>>>> removePeripheral")
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: STORED_PERIPHERAL_IDENTIFIER)
        userDefaults.synchronize()
        disconnect()
    }
    
    public func isPeripheralRegistered()->Bool{
        let userDefaults = UserDefaults.standard
        let peripheralUUID = userDefaults.string(forKey: STORED_PERIPHERAL_IDENTIFIER)
        return (peripheralUUID != nil)
    }
    
    func disconnect(){
        print(">>>>>>>>> disconnect")
        if heartMonitor != nil {
            print("disconnecting.....")
            self.centralManager.cancelPeripheralConnection(heartMonitor!)
            self.heartMonitor = nil
            print("disconnected")
        }
    }
    func disconnect(peripheraler: CBPeripheral){
        print(">>>>>>>>> disconnect")
        
        DispatchQueue.main.async {
            if self.heartMonitor != nil {
                print("disconnecting.....")
                self.centralManager.cancelPeripheralConnection(peripheraler)
                self.heartMonitor = nil
                print("disconnected")
            }
        }
        
    }
    func getHeartBPMData(characteristic: CBCharacteristic, error: Error?,peripheral: CBPeripheral) {
        if error != nil { print(" getHeartBPMData:: \(error!)") }
        
        let heartRateValue = characteristic.value!
        // convert to an array of unsigned 32-bit integers
        let buffer = [UInt8](heartRateValue)
        
        if ((buffer[0] & 0x01) == 0) {
            
            let firstOctet = UInt32(buffer[1])&0x00FF
            let secondOctet = UInt32(buffer[2])&0x00FF
            let mantissa = ((firstOctet)|(secondOctet<<8))&UInt32(0x00FFFFFF)
            print(mantissa)
        }
        
    }
    func convertFahrenheit(mBatteryCharacteritsic: CBCharacteristic) {
        let str = "b"
        if let data = str.data(using: String.Encoding.utf8) {
            self.heartMonitor?.writeValue(data, for: mBatteryCharacteritsic, type: .withoutResponse)
        }
    }
   
    
}
