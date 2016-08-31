//
//  SongObject.swift
//  RealMusic
//
//  Created by asiantech on 8/30/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Song: Object,Mappable {
    dynamic var id = 0
    dynamic var kind = ""
    dynamic var created_at = ""
    dynamic var user_id = ""
    dynamic var duration = ""
    dynamic var commentable = ""
    dynamic var state = ""
    dynamic var original_content_size = ""
    dynamic var last_modified = ""
    dynamic var sharing = ""
    dynamic var tag_list = ""
    dynamic var permalink = ""
    dynamic var embeddable_by = ""
    dynamic var genre = ""
    dynamic var title = ""
    dynamic var descriptions = ""
    dynamic var uri = ""
    dynamic var permalink_url = ""
    dynamic var artwork_url = ""
    dynamic var waveform_url = ""
    dynamic var playback_count = 0
    dynamic var download_count = 0
    dynamic var favoritings_count = 0
    dynamic var comment_count = 0
    dynamic var attachments_uri = ""
    dynamic var user: User!
    dynamic var first_name = ""
    dynamic var website = ""
    dynamic var city = ""
    dynamic var username = ""
    dynamic var full_name = ""
    dynamic var online = ""
    dynamic var followers_count = 0
    dynamic var country = ""
    dynamic var track_count = ""
    dynamic var last_name = ""
    dynamic var playlist_count = 0
    dynamic var public_favorites_count = 0
    dynamic var avatar_url = ""
    dynamic var plan = ""
    dynamic var myspace_name = ""
    
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        kind <- map["kind"]
        created_at <- map["created_at"]
        user_id <- map["user_id"]
        duration <- map["duration"]
        commentable <- map["commentable"]
        state <- map["state"]
        original_content_size <- map["original_content_size"]
        last_modified <- map["last_modified"]
        sharing <- map["sharing"]
        tag_list <- map["tag_list"]
        permalink <- map["permalink"]
        embeddable_by <- map["embeddable_by"]
        genre <- map["genre"]
        title <- map["title"]
        descriptions <- map["description"]
        uri <- map["uri"]
        permalink_url <- map["permalink_url"]
        artwork_url <- map["artwork_url"]
        waveform_url <- map["waveform_url"]
        playback_count <- map["playback_count"]
        download_count <- map["download_count"]
        favoritings_count <- map["favoritings_count"]
        comment_count <- map["comment_count"]
        attachments_uri <- map["attachments_uri"]
        user <- map["user"]
        first_name <- map["first_name"]
        website <- map["website"]
        city <- map["city"]
        username <- map["username"]
        full_name <- map["full_name"]
        online <- map["online"]
        followers_count <- map["followers_count"]
        country <- map["country"]
        track_count <- map["track_count"]
        last_name <- map["last_name"]
        playlist_count <- map["playlist_count"]
        public_favorites_count <- map["public_favorites_count"]
        avatar_url <- map["avatar_url"]
        plan <- map["plan"]
        myspace_name <- map["myspace_name"]
    }
    
}
