//
//  CacheUsersGateway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

class CacheUsersGateway: UserGateway {
    func login(parameters: UserEntity, completionHandler: @escaping LoginGatewayCompletionHandler) {
        
    }
    
    let localPersistenceUsersGateway: LocalPersistenceUserGateway
    init(localPersistenceUsersGateway: LocalPersistenceUserGateway){
        self.localPersistenceUsersGateway = localPersistenceUsersGateway
    }
    
    // MARK: - Private
    
    fileprivate func handleFetchBooksApiResult(_ result: Result<UserEntity>, completionHandler: @escaping (Result<UserEntity>) -> Void) {
        switch result {
        case let .success(user):
            localPersistenceUsersGateway.saveUser(user)
            completionHandler(result)
        case .failure(_):
           completionHandler(result)
        }
    }
    
    

    
}
