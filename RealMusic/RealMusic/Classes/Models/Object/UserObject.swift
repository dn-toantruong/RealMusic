//
//  UserObject.swift
//  RealMusic
//
//  Created by asiantech on 8/30/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class User: Object, Mappable {
    dynamic var id = 0
    dynamic var kind = ""
    dynamic var permalink = ""
    dynamic var username = ""
    dynamic var last_modified = ""
    dynamic var uri = ""
    dynamic var permalink_url = ""
    dynamic var avatar_url = ""
    dynamic var followers_count = 0
    dynamic var followings_count = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        kind <- map["kind"]
        permalink <- map["permalink"]
        username <- map["username"]
        last_modified <- map["last_modified"]
        uri <- map["uri"]
        permalink_url <- map["permalink_url"]
        avatar_url <- map["avatar_url"]
        followers_count <- map["followers_count"]
        followings_count <- map["followings_count"]
    }
}
