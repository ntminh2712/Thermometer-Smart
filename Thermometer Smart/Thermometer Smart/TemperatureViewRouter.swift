//
//  TemperatureViewRouter.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
protocol TemperatureViewRouter {
    
}

class TemperatureRouterImplemetation: TemperatureViewRouter
{
    fileprivate weak var temperatureController: TemperatureViewController?
    
    init(temperatureController: TemperatureViewController) {
        self.temperatureController = temperatureController
    }
}
