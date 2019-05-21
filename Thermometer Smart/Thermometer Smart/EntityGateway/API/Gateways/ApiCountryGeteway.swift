
//
//  ApiCountryGeteway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

protocol ApiCountryGeteway: CountryGateway {

}

class ApiCountryGatewayImplementation: ApiCountryGeteway
{
    func fetchCountry(type: String, language: String, complettionHandler: @escaping FetchCountryEntityGatewayCompletionHandler) {
        apiProvider.request(TSAPI.i18nRegions(type, language)).asObservable().mapObject(RegionEntity.self).subscribe(onNext:{(result) in
            complettionHandler(.success(result))
        }, onError:{(error) in
            complettionHandler(.failure(error))
        })
    }
    
    
}
