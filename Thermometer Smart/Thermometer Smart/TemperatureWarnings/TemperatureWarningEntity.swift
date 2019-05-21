//
//  TemperatureWarningEntity.swift
//  BabyCare
//
//  Created by HOANDHTB on 10/1/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
class TemperatureWarningEntity: Object, Mappable {
    @objc dynamic var id:String = ""
    @objc dynamic var deviceId: String = ""
    @objc dynamic var warningType:String = ""
    @objc dynamic var nickName: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var value: Double = 0.0
    @objc dynamic var deviceTime: Int = 0
    @objc dynamic var isInterupt:Bool = false
    @objc dynamic var macAddress: String = ""
    private var strDeviceTime:String = ""
    public var isExpand:Bool = false
    override static func primaryKey() -> String? {
        return "id"
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        deviceId <- map["device_id"]
        warningType <- map["warning_type"]
        nickName <- map["nick_name"]
        avatar <- map["avatar"]
        value <- map["value"]
        strDeviceTime <- map["device_time"]
        macAddress <- map["mac_address"]
        if strDeviceTime.isEmpty
        {
            deviceTime <- map["device_time"]
        }
        else
        {
            deviceTime = Int(strDeviceTime) ?? 0
        }
    }
}
extension TemperatureWarningEntity
{
    class  func incrementID() -> String {
        let someDate = Date()
        return "\(someDate.timeIntervalSince1970)"
    }
    class func overiteObject(temperature: TemperatureWarningEntity) -> TemperatureWarningEntity
    {
        let temperatureNew = TemperatureWarningEntity()
        temperatureNew.id = temperature.id
        temperatureNew.value = temperature.value
        temperatureNew.deviceId = temperature.deviceId
        temperatureNew.nickName = temperature.nickName
         temperatureNew.avatar = temperature.avatar
        temperatureNew.deviceTime = temperature.deviceTime
         temperatureNew.warningType = temperature.warningType
        return temperatureNew
    }
    class func saveTemperature(_ temperature: TemperatureWarningEntity) -> Bool
    {
        let temperatureOld = TemperatureWarningEntity.getTemperature(temperature.id)
        do
        {
            let realm = RealmConnectorManager.connectDefault()
            try! realm?.write {
                if temperatureOld != nil
                {
                    realm?.add(temperature, update: true)
                    return
                }
                realm?.add(temperature, update: false)
                
            }
            return true
        }
        catch let error as NSError
        {
            Log.debug(message: error.description)
            return false
        }
    }
    
    
    class func deleteTemperature(_ idTemperature: Int) {
        do {
            let realm = RealmConnectorManager.connectDefault()
            guard let temperature = realm?.object(ofType: TemperatureWarningEntity.self, forPrimaryKey: idTemperature) else { return }
            try realm?.write {
                realm?.delete(temperature)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    
    
    class func deletAll()
    {
        do {
            let realm = RealmConnectorManager.connectDefault()
            guard let temperature = realm?.objects(TemperatureWarningEntity.self) else { return }
            try realm?.write {
                realm?.delete(temperature)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    
    
   
    class func deleteFollowBaby(idBaby:String)
    {
        do{
            let realm = RealmConnectorManager.connectDefault()
            let predicate = NSPredicate(format: "deviceId= %@",  idBaby)
            let list = (realm?.objects(TemperatureWarningEntity.self).filter(predicate))
            try realm?.write {
                realm?.delete(list!)
            }
        }catch let error as NSError {
            Log.debug(message: error.description)
            
        }
    }
    
    

   class func getAll() -> [TemperatureWarningEntity]
    {
        do{
            let realm = RealmConnectorManager.connectDefault()
            let predict = NSPredicate(format: "isInterupt == %@",  NSNumber(value: false))
            return (realm?.objects(TemperatureWarningEntity.self).filter(predict).toArray(ofType: TemperatureWarningEntity.self))!
        }catch let error as NSError {
            Log.debug(message: error.description)
            return []
        }
    }
    
    
    
    class func getAllInterupt() -> [TemperatureWarningEntity]
    {
        do{
            let realm = RealmConnectorManager.connectDefault()
            let predict = NSPredicate(format: "isInterupt == %@",  NSNumber(value: true))
            return (realm?.objects(TemperatureWarningEntity.self).filter(predict).toArray(ofType: TemperatureWarningEntity.self))!
        }catch let error as NSError {
            Log.debug(message: error.description)
            return []
        }
    }
    
   
    
    class func getTemperature(_ id: String) -> TemperatureWarningEntity?
    {
        do{
            let realm = RealmConnectorManager.connectDefault()
            return realm?.object(ofType: TemperatureWarningEntity.self, forPrimaryKey: id)
        }catch let error as NSError {
            Log.debug(message: error.description)
            return nil
        }
    }
    

}
