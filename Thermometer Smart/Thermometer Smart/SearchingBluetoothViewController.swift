//
//  SearchingBluetoothViewController.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import UIKit
import CoreBluetooth
import NVActivityIndicatorView


class SearchingBluetoothViewController:BaseViewController, SearchingBluetoothView, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    
    let bluetoothService = BluetoothService()
    lazy var pairingFlow = PairingFlow(bluetoothSerivce: self.bluetoothService)

    var manager : CBCentralManager!
    
    
    @IBOutlet weak var loading: NVActivityIndicatorView!
    @IBOutlet weak var loading2: NVActivityIndicatorView!
    @IBOutlet weak var tbDevice: UITableView!
    
    var presenter: SearchingBluetoothPeresenter?
    var config : SearchingBluetoothConfiguration = SearchingBluetoothConfigurationImplementation()
    
    var isPresent: Bool = true
    var peripherals:[DisplayPeripheral] = []
    var heartMonitorData:ThermometerTemperatureMonitor?{
        didSet{
            heartMonitorData?.updateList = { (list:[DisplayPeripheral]) in
                self.peripherals = list
                DispatchQueue.main.async {
                    // nếu là thay thế thiết bị
                    self.tbDevice.reloadData()
                }
            }

            heartMonitorData?.poweredOff = {
                DispatchQueue.main.async {
                    self.showAlertWithOnlyCancelAction(title: "Thông báo", message: "Bạn chưa bật bluetooth", alertType: .alert, cancelTitle: "OK", cancelActionHandler: nil)
                }
            }
        }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
    }
    
    
    @IBAction func refreshScan(_ sender: Any) {
        heartMonitorData?.startScanning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config.configure(searchingBluetoothControler: self)
        configTableView()
        setLoading()
        self.bluetoothService.flowController = self.pairingFlow
        self.bluetoothService.startScan()
        if Thermometer.heartMonitor == nil
        {
            Thermometer.heartMonitor = ThermometerTemperatureMonitor()
        }

        heartMonitorData = Thermometer.heartMonitor
        self.heartMonitorData?.startScanning()
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkBluetoothState()
    }
    private func checkBluetoothState() {
//        self.statusLabel.text = "Status: bluetooth is \(bluetoothService.bluetoothState == .poweredOn ? "ON" : "OFF")"
        
        if #available(iOS 10.0, *) {
            if self.bluetoothService.bluetoothState != .poweredOn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.checkBluetoothState() }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    func configTableView() {
        tbDevice.delegate = self
        tbDevice.dataSource = self
        tbDevice.register(UINib(nibName: "DeviceTableViewCell", bundle: nil), forCellReuseIdentifier: "DeviceTableViewCell")
    }
    
    func setLoading() {
        loading2.color = #colorLiteral(red: 0.05251948535, green: 0.7849897742, blue: 0.8240693212, alpha: 1)
        loading2.type = .ballBeat
        loading.color = #colorLiteral(red: 0.05251948535, green: 0.7849897742, blue: 0.8240693212, alpha: 1)
        loading.type = .ballBeat
        loading2.startAnimating()
        loading.startAnimating()
    }
    private func connectSensor(displaySensor: DisplayPeripheral, isBreak: Bool = false, macAddress: String)
    {
        let sensor = displaySensor.peripheral
        self.heartMonitorData?.centralManager.connect(sensor, options: nil)
        self.heartMonitorData?.stopScanning()
    }

}
extension SearchingBluetoothViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell") as! DeviceTableViewCell
        cell.displayPeripheral = peripherals[indexPath.row]
        cell.connect = {
            [weak self] in
            var displaySensor = self?.peripherals[indexPath.item]
            displaySensor!.macAddress = cell.lbMac.text!
            self?.connectSensor(displaySensor: displaySensor!, isBreak: false, macAddress:  cell.lbMac.text!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
