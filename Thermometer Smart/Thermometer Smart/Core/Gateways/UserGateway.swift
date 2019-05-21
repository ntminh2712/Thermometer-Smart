//
//  UserGateway.swift
//  FoxLive
//
//  Created by HOANDHTB on 10/4/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import Foundation

typealias LoginGatewayCompletionHandler = (_ user: Result<UserEntity>) -> Void
typealias RegisterGatewayCompletionHandler = (_ books: Result<UserEntity>) -> Void


protocol UserGateway {
    func login(parameters: UserEntity, completionHandler: @escaping LoginGatewayCompletionHandler)
}
