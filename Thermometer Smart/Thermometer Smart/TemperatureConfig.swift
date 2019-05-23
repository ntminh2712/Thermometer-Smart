//
//  TemperatureConfig.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
protocol TemperatureConfiguration {
    func configure(temperatureControler: TemperatureViewController)
}
class TemperatureConfigurationImplementation:  TemperatureConfiguration {
    func configure(temperatureControler: TemperatureViewController) {
        
        let router = TemperatureRouterImplemetation(temperatureController: temperatureControler)
        
        let presenter = TemperaturePresenterImplementation(view: temperatureControler, router: router)
        temperatureControler.presenter = presenter
    }
    
    
}
