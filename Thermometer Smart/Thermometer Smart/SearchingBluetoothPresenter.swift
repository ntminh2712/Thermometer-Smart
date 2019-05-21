//
//  SearchingBluetoothPresenter.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation

protocol SearchingBluetoothView: class {
    
}


protocol SearchingBluetoothPeresenter {
    
    func viewDidLoad()
    func startScanning()
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
    
}

