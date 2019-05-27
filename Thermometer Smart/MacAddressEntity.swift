//
//  MacAddressEntity.swift
//  BabyCare
//
//  Created by HOANDHTB on 12/2/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import RealmSwift
class MacAddressEntity: Object {
   @objc public dynamic var id: Int = 0
   @objc public dynamic var mac: String = ""
    
}
extension MacAddressEntity
{
//    class  func incrementID() -> Int {
//        let realm =  RealmConnectorManager.connectDefault()
//        return (realm?.objects(TreatmentEntity.self).max(ofProperty: "id") as Int? ?? 0) + 1
//    }
    
//    class func overiteObject(mac: MacAddressEntity) -> MacAddressEntity
//    {
//        let macNew = MacAddressEntity()
//        macNew.id = mac.id
//        macNew.mac = mac.mac
//        return macNew
//    }
//    class func saveMac(_ macAddressEntity: MacAddressEntity)
//    {
//        let macOld = MacAddressEntity.getMacEntity(mac: macAddressEntity.mac)
//        do
//        {
//            let realm = RealmConnectorManager.connectDefault()
//            try! realm?.write {
//                if macOld != nil
//                {
//                    realm?.add(macAddressEntity, update: true)
//                    return
//                }
//                realm?.add(macAddressEntity, update: false)
//            }
//            
//        }
//        catch let error as NSError
//        {
//            Log.debug(message: error.description)
//            
//        }
//    }
//    
//    class func getMacEntity(mac: String) -> MacAddressEntity?
//    {
//        do{
//            let realm = RealmConnectorManager.connectDefault()
//            let predicate: NSPredicate = NSPredicate(format: "mac = %@", mac)
//            return realm?.objects(MacAddressEntity.self).filter(predicate).first
//        }catch let error as NSError {
//            Log.debug(message: error.description)
//            return nil
//        }
//    }
//    
}
