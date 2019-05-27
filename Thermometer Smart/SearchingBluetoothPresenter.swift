//
//  SearchingBluetoothPresenter.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation

protocol SearchingBluetoothView: class {
    func connectSensor(displaySensor: DisplayPeripheral)
}


protocol SearchingBluetoothPeresenter {
    
    func viewDidLoad()
    func presentTemperature()
    func autoConnectToDeviceLastConnect()
}

class SearchingBluetoothPresenterImplementation: SearchingBluetoothPeresenter{
    fileprivate weak var view: SearchingBluetoothView?
    internal let router: SearchingBluetoothViewRouter
    
    
    init(view: SearchingBluetoothView, router: SearchingBluetoothViewRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    func startScanning(){
        
    }
    func presentTemperature() {
        self.router.presentTemperature()
    }
    func autoConnectToDeviceLastConnect() {
//        guard DisplayPeripheral.getPeripheral()?.count == 0 else { return }
//        self.view?.connectSensor(displaySensor: (DisplayPeripheral.getPeripheral()?[0])!)
    }
    
}

