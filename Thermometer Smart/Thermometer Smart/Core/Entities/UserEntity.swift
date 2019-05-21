//
//  UserEntity.swift
//  FoxLive
//
//  Created by HOANDHTB on 10/4/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
class UserEntity: Object, Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    @objc dynamic var id: String?
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var password: String?
    @objc dynamic var birthDate: Date?
    @objc dynamic var username: String?
    @objc dynamic var email: String?
    @objc dynamic var create_date: Date?
    
    @objc dynamic var language_code: String?
    @objc dynamic var acct_name: String?
    @objc dynamic var fullname: String?
    @objc dynamic var agent_name: String?
    @objc  dynamic var birthday: Date?
    @objc dynamic var currency: String?
    @objc  dynamic var id_card: String?
    @objc dynamic var photo_1: String?
    @objc dynamic var last_login: String?
    @objc dynamic var card_type_id: String?
    @objc dynamic var photo_2: String?
    @objc dynamic var isVerified: Bool = false
    @objc dynamic var gender: String?
    @objc dynamic var count_login: String?
    @objc dynamic var phone_num: String?
    @objc dynamic var province_name: String?
    @objc dynamic var district_name: String?
    @objc dynamic var fb_avatar: String?
    @objc dynamic var avatar: String?
    @objc dynamic var bank_name: String?
    @objc dynamic var describe: String?
    @objc dynamic var pay_acct: String?
    @objc dynamic var address: String?
    @objc dynamic var token_key:String?
    @objc dynamic var aboutme: String?
    @objc dynamic var country_code: String?
    @objc dynamic var district_id: String?
    @objc dynamic var province_id: String?
    @objc dynamic var government_type: String?
    @objc dynamic var government_number: String?
    @objc dynamic var is_become_host =  ""
    @objc dynamic var isSwtichHost = false
    @objc dynamic var descriptionApt: String?
    @objc dynamic var expertise_id = 0
    @objc dynamic var share_link: String?
    @objc dynamic var isSelected = false
    @objc  dynamic var is_become_agent = ""
    var content = ""
    var result = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
   
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        language_code <- map["language_code"]
        acct_name <- map["acct_name"]
        fullname <- map["fullname"]
        agent_name <- map["agent_name"]
        birthday <- (map["birthday"], TSDateTransform())
        currency <- map["currency"]
        create_date <- (map["create_date"], TSUserDateTransform())
        id_card <- map["id_card"]
        last_login <- map["last_login"]
        card_type_id <- map["card_type_id"]
        photo_2 <- map["photo_2"]
        isVerified <- map["verified"]
        gender <- map["gender"]
        count_login <- map["count_login"]
        email <- map["email"]
        phone_num <- map["phone_num"]
        province_name <- map["province_name"]
        district_name <- map["district_name"]
        fb_avatar <- map["fb_avatar"]
        avatar <- map["avatar"]
        bank_name <- map["bank_name"]
        describe <- map["describe"]
        pay_acct <- map["pay_acct"]
        address <- map["address"]
        username <- map["username"]
        //        token_key <- map["token_key"]
        aboutme <- map["aboutme"]
        country_code <- map["country_code"]
        district_id <- map["district_id"]
        province_id <- map["province_id"]
        government_type <- map["government_type"]
        government_number <- map["government_number"]
        is_become_host <- map["is_become_host"]
        expertise_id <- map["expertise_id"]
        share_link <- map["share_link"]
        photo_1 <- map["photo_1"]
        content <- map["content"]
        result <- map["result"]
        is_become_agent <- map["is_become_agent"]
    }
    
}
