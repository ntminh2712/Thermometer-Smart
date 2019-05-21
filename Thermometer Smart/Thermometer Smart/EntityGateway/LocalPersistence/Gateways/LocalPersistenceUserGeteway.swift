//
//  LocalPersistenceUserGeteway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit
import RealmSwift
protocol LocalPersistenceUserGateway {
    func saveUser(_ user: UserEntity)
    
    func deleteUser(_ userId: String)
    
    func getUser(_ userId: String) -> UserEntity?
    
    func getFirstUser() -> UserEntity?
}
