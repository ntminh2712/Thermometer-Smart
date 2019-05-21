
//
//  DisplayCountryList.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

typealias DisplayCountryUseCaseCompletionHandler = (_ books: Result<RegionEntity>) -> Void

protocol DisplayCountryListUseCase {
    func displayCountry(type:String, language: String, completionHandler: @escaping DisplayCountryUseCaseCompletionHandler)
}

class DisplayCountryListUseCaseImplementation: DisplayCountryListUseCase {
    let countryGateWay: CountryGateway
 
    init(countryGateWay: CountryGateway) {
        self.countryGateWay = countryGateWay
    }
    
     func displayCountry(type:String, language: String, completionHandler: @escaping DisplayCountryUseCaseCompletionHandler){
        self.countryGateWay.fetchCountry(type: type, language: language){
            (result) in
            completionHandler(result)
        }
    }
    
}
