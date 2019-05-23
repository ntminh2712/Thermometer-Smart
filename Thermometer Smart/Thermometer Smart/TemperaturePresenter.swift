//
//  TemperaturePresenter.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import Foundation
protocol TemperatureView: class {
    
}


protocol TemperaturePeresenter {
    
    func viewDidLoad()
}

class TemperaturePresenterImplementation: TemperaturePeresenter{
    fileprivate weak var view: TemperatureView?
    internal let router: TemperatureViewRouter
    
    
    init(view: TemperatureView, router: TemperatureViewRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
   
    
}
