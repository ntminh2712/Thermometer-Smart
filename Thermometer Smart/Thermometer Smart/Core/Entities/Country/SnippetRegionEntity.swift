//
//  SnippetRegionEntity.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
class SnippetRegionEntity: Object, Mappable{
    
    @objc dynamic var gl: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "gl"
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        gl <- map["gl"]
        name <- map["name"]
    }
}
extension SnippetRegionEntity
{
    class func saveSnippetWhithGl(from oldSnippet: SnippetRegionEntity?, to newSnippet: SnippetRegionEntity)
    {
        if let oldSnippet  = oldSnippet
        {
            do
            {
                let realm = try Realm()
                try realm.write {
                    newSnippet.gl = oldSnippet.gl
                    realm.add(oldSnippet, update: true)
                }
            }
            catch let error as NSError {
                Log.debug(message: error.description)
            }
        }
        else
        {
            
        }
    }
    class func saveSnippet(_ snippet: SnippetRegionEntity)
    {
        let gl:String? = SnippetRegionEntity.getFirstSnippet()?.gl
        do
        {
            let realm = try Realm()
            try realm.write {
                if gl != nil
                {
                    snippet.gl = gl!;
                }
                realm.add(snippet, update: true)
            }
        }
        catch let error as NSError
        {
            Log.debug(message: error.description)
        }
    }
    
    class func deleteSnippet(_ gl: String) {
        do {
            let realm = try Realm()
            guard let user = realm.object(ofType: SnippetRegionEntity.self, forPrimaryKey: gl) else { return }
            try realm.write {
                realm.delete(user)
            }
        } catch let error as NSError {
            Log.debug(message: error.description)
        }
    }
    
    class func getSnippet(_ gl: String) -> SnippetRegionEntity? {
        do {
            let realm = try Realm()
            return realm.object(ofType: SnippetRegionEntity.self, forPrimaryKey: gl)
        } catch let error as NSError {
            Log.debug(message: error.description)
            return nil
        }
    }
    
    
    class func getFirstSnippet() -> SnippetRegionEntity?{
        do{
            let realm = try Realm()
            return realm.objects(SnippetRegionEntity.self).first
        }catch let error as NSError {
            Log.debug(message: error.description)
            return nil
        }
    }
    
    class func deleteAll()
    {
        do
        {
            let realm = try Realm()
            try realm.write {
                let snippetRegionEntityOld = realm.objects(SnippetRegionEntity.self)
                realm.delete(snippetRegionEntityOld)
            }
            
        }
        catch let error as NSError
        {
            Log.debug(message: error.description)
        }
    }
}
