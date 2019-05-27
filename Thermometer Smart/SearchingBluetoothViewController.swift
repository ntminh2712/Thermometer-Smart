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

class SearchingBluetoothViewController:BaseViewController, SearchingBluetoothView {
    
    let bluetoothService = BluetoothService()
    lazy var pairingFlow = PairingFlow(bluetoothSerivce: self.bluetoothService)
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
        
    }
    
    override func initInterface() {
        self.bluetoothService.flowController = self.pairingFlow
        self.bluetoothService.startScan()
        if Thermometer.heartMonitor == nil
        {
            Thermometer.heartMonitor = ThermometerTemperatureMonitor()
        }
        
        heartMonitorData = Thermometer.heartMonitor
        self.heartMonitorData?.startScanning()
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentTemperature), name: notificationName.presentTemperature.notification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkBluetoothState()
    }
    private func checkBluetoothState() {
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
    
    func connectSensor(displaySensor: DisplayPeripheral)
    {
        let sensor = displaySensor.peripheral
        self.heartMonitorData?.centralManager.connect(sensor, options: nil)
        self.heartMonitorData?.stopScanning()
//        DisplayPeripheral.savePeripheral(displaySensor)
    }
    
    @objc func presentTemperature() {
        self.presenter?.presentTemperature()
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
            DataSingleton.displayPeripheral = self?.peripherals[indexPath.row]
            self?.connectSensor(displaySensor: displaySensor!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
