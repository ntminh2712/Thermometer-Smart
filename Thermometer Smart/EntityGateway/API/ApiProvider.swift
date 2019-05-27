//
//  ApiProvider.swift
//  TrueStay
//
//  Created by navatech on 7/14/18.
//  Copyright © 2017 nava. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import RxSwift

let endpointClosure = { (target: TSAPI) -> Endpoint<TSAPI> in
    
    let endpoint: Endpoint<TSAPI> = Endpoint<TSAPI>(
        url: target.baseURL.absoluteString + target.path,
        sampleResponseClosure: {
            .networkResponse(204, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    
    switch target {
    default:
        return endpoint.adding(newHTTPHeaderFields:["security_code": "vi"])
    }
}

let apiProvider =
    OnlineProvider<TSAPI>(endpointClosure: endpointClosure,
                          plugins: [NetworkLoggerPlugin(verbose: true,
                                                        responseDataFormatter: JSONResponseDataFormatter)])

class OnlineProvider<TSAPI>: MoyaProvider<TSAPI> where TSAPI: TargetType {
    
    static var AlamofireManager: SessionManager {
        // manager
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        return manager
    }
    
    override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                  requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
                  stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                  callbackQueue: DispatchQueue? = DispatchQueue.main,
                  manager: Manager = OnlineProvider.AlamofireManager,
                  plugins: [PluginType] = [],
                  trackInflights: Bool = false) {
        
        let managerAlamofire = OnlineProvider.AlamofireManager
        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   manager: managerAlamofire, plugins: plugins, trackInflights: trackInflights)
    }
    /*
     func request(_ token: TSAPI, callbackQueue: DispatchQueue? = DispatchQueue.main) ->
     PrimitiveSequence<SingleTrait, Moya.Response> {
     let actualRequest = super.request(token)
     return actualRequest.asSingle()
     }
     */
}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    class TestClass: NSObject { }
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}


extension MoyaProvider{
    open func request(_ token: Target, queue: DispatchQueue? = nil) -> Observable<Response> {
        // Creates an observable that starts a request each time it's subscribed to.
        return Observable.create { observer in
            let cancellableToken = self.request(token, callbackQueue: queue) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}
