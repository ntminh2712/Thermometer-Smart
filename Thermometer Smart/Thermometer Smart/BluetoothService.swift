//
//  BluetoothService.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
import CoreBluetooth
class FlowController {
    
    weak var bluetoothSerivce: BluetoothService? // 1.
    
    init(bluetoothSerivce: BluetoothService) {
        self.bluetoothSerivce = bluetoothSerivce
    }
    
    func bluetoothOn() {
        
    }
    
    func bluetoothOff() {
    }
    
    func scanStarted() {
        
    }
    
    func scanStopped() {
        
    }
    
    func connected(peripheral: CBPeripheral) {
    }
    
    func disconnected(failure: Bool) {
    }
    
    func discoveredPeripheral() {
    }
    
    func readyToWrite() {
    }
    
    func received(response: Data) {
    }
    
    // TODO: add other events if needed
}
class BluetoothService: NSObject { // 1.
    
    // 2.
    let dataServiceUuid = "180A"
    let dataCharacteristicUuid = "2A29"
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    var dataCharacteristic: CBCharacteristic?
    @available(iOS 10.0, *)
    var bluetoothState: CBManagerState {
        return self.centralManager.state
    }
    var flowController: FlowController? // 3.
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        self.peripheral = nil
//        guard self.centralManager.state == .poweredOn else { return }
        
        self.centralManager.scanForPeripherals(withServices: []) // 4.
        self.flowController?.scanStarted() // 5.
        print("scan started")
    }
    
    func stopScan() {
        self.centralManager.stopScan()
        self.flowController?.scanStopped() // 5.
        print("scan stopped\n")
    }
    
    func connect() {
        guard self.centralManager.state == .poweredOn else { return }
        guard let peripheral = self.peripheral else { return }
        self.centralManager.connect(peripheral)
    }
    
    func disconnect() {
        guard let peripheral = self.peripheral else { return }
        self.centralManager.cancelPeripheralConnection(peripheral)
    }
}
extension BluetoothService: CBCentralManagerDelegate {
    
    var expectedNamePrefix: String { return "GoPro" } // 1.
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            print("bluetooth is OFF (\(central.state.rawValue))")
            self.stopScan()
            self.disconnect()
            self.flowController?.bluetoothOff() // 2.
        } else {
            print("bluetooth is ON")
            self.flowController?.bluetoothOn() // 2.
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard peripheral.name != nil && peripheral.name?.starts(with: self.expectedNamePrefix) ?? false else { return } // 1.
        print("discovered peripheral: \(peripheral.name!)")
        
        self.peripheral = peripheral
        self.flowController?.discoveredPeripheral()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if let periperalName = peripheral.name {
            print("connected to: \(periperalName)")
        } else {
            print("connected to peripheral")
        }
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        self.flowController?.connected(peripheral: peripheral) // 2.
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("peripheral disconnected")
        self.dataCharacteristic = nil
        self.flowController?.disconnected(failure: false) // 2.
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect: \(error.debugDescription)")
        self.dataCharacteristic = nil
        self.flowController?.disconnected(failure: true) // 2.
    }
}
extension BluetoothService: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        print("services discovered")
        for service in services {
            let serviceUuid = service.uuid.uuidString
            print("discovered service: \(serviceUuid)")
            
            if serviceUuid == self.dataServiceUuid {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        print("characteristics discovered")
        for characteristic in characteristics {
            let characteristicUuid = characteristic.uuid.uuidString
            print("discovered characteristic: \(characteristicUuid) | read=\(characteristic.properties.contains(.read)) | write=\(characteristic.properties.contains(.write))")
            
            if characteristicUuid == self.dataCharacteristicUuid {
                peripheral.setNotifyValue(true, for: characteristic)
                
                self.dataCharacteristic = characteristic
                self.flowController?.readyToWrite() // 1.
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            print("didUpdateValueFor \(characteristic.uuid.uuidString) = count: \(data.count) | \(self.hexEncodedString(data))")
            self.flowController?.received(response: data) // 1.
        } else {
            print("didUpdateValueFor \(characteristic.uuid.uuidString) with no data")
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("error while writing value to \(characteristic.uuid.uuidString): \(error.debugDescription)")
        } else {
            print("didWriteValueFor \(characteristic.uuid.uuidString)")
        }
    }
    
    private func hexEncodedString(_ data: Data?) -> String {
        let format = "0x%02hhX "
        return data?.map { String(format: format, $0) }.joined() ?? ""
    }
}
extension BluetoothService {
    
    func getSettings() {
        self.peripheral?.readValue(for: self.dataCharacteristic!)
    }
    
    // TODO: add other methods to expose high level requests to peripheral
}
class PairingFlow: FlowController {
    
    let timeout = 15.0
    var waitForPeripheralHandler: () -> Void = { }
    var pairingHandler: (Bool) -> Void = { _ in }
    var pairingWorkitem: DispatchWorkItem?
    var pairing = false
    
    // MARK: 1. Pairing steps
    
    func waitForPeripheral(completion: @escaping () -> Void) {
        self.pairing = false
        self.pairingHandler = { _ in }
        
        self.bluetoothSerivce?.startScan()
        self.waitForPeripheralHandler = completion
    }
    
    func pair(completion: @escaping (Bool) -> Void) {
        guard self.bluetoothSerivce?.centralManager.state == .poweredOn else {
            print("bluetooth is off")
            self.pairingFailed()
            return
        }
        guard let peripheral = self.bluetoothSerivce?.peripheral else {
            print("peripheral not found")
            self.pairingFailed()
            return
        }
        
        self.pairing = true
        self.pairingWorkitem = DispatchWorkItem { // 2.
            print("pairing timed out")
            self.pairingFailed()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeout, execute: self.pairingWorkitem!) // 2.
        
        print("pairing...")
        self.pairingHandler = completion
        self.bluetoothSerivce?.centralManager.connect(peripheral)
    }
    
    func cancel() {
        self.bluetoothSerivce?.stopScan()
        self.bluetoothSerivce?.disconnect()
        self.pairingWorkitem?.cancel()
        
        self.pairing = false
        self.pairingHandler = { _ in }
        self.waitForPeripheralHandler = { }
    }
    
    // MARK: 3. State handling
    
    override func discoveredPeripheral() {
        self.bluetoothSerivce?.stopScan()
        self.waitForPeripheralHandler()
    }
    
    override func readyToWrite() {
        guard self.pairing else { return }
        
        self.bluetoothSerivce?.getSettings() // 4.
    }
    
    override func received(response: Data) {
        print("received data: \(String(bytes: response, encoding: String.Encoding.ascii) ?? "")") // 5.
        // TODO: validate response to confirm that pairing is sucessful
        self.pairingHandler(true)
        self.cancel()
    }
    
    override func disconnected(failure: Bool) {
        self.pairingFailed()
    }
    
    private func pairingFailed() {
        self.pairingHandler(false)
        self.cancel()
    }
}
