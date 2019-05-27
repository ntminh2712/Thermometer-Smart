//
//  SearchingBluetoothConfiguration.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation

protocol SearchingBluetoothConfiguration {
    func configure(searchingBluetoothControler: SearchingBluetoothViewController)
}
class SearchingBluetoothConfigurationImplementation:  SearchingBluetoothConfiguration {
    func configure(searchingBluetoothControler: SearchingBluetoothViewController) {
        
        let router = SearchingBluetoothRouterImplemetation(searchingBluetoothController: searchingBluetoothControler)
        
        let presenter = SearchingBluetoothPresenterImplementation(view: searchingBluetoothControler, router: router)
        searchingBluetoothControler.presenter = presenter
    }
    
    
}
