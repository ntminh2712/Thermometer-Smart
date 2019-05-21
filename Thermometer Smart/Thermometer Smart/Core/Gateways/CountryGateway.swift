//
//  CountryGateway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import Foundation

typealias FetchCountryEntityGatewayCompletionHandler = (_ region: Result<RegionEntity>) -> Void

protocol CountryGateway {
    func fetchCountry(type: String,language: String, complettionHandler: @escaping FetchCountryEntityGatewayCompletionHandler)
}
