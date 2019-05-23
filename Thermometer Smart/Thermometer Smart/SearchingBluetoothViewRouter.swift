//
//  SearchingBluetoothViewRouter.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
import UIKit
protocol SearchingBluetoothViewRouter {
    func presentTemperature()
    
}

class SearchingBluetoothRouterImplemetation: SearchingBluetoothViewRouter
{
    fileprivate weak var searchingBluetoothController: SearchingBluetoothViewController?
    
    init(searchingBluetoothController: SearchingBluetoothViewController) {
        self.searchingBluetoothController = searchingBluetoothController
    }
    
    func presentTemperature() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "temperatureView") as! TemperatureViewController
        searchingBluetoothController!.present(newViewController, animated: true, completion: nil)
    }
    
}
