//
//  SearchingBluetoothViewRouter.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
protocol SearchingBluetoothViewRouter {
    
}

class SearchingBluetoothRouterImplemetation: SearchingBluetoothViewRouter
{
    fileprivate weak var searchingBluetoothController: SearchingBluetoothViewController?
    
    init(searchingBluetoothController: SearchingBluetoothViewController) {
        self.searchingBluetoothController = searchingBluetoothController
    }
}
