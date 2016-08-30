//
//  Webservice.swift
//  RealMusic
//
//  Created by asiantech on 8/29/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import ObjectMapper

typealias APIControllerCallBack = (success: Bool, result: [AnyObject]?, error: NSError?) -> Void
//https://api.soundcloud.com/search?client_id=97effc2d5a8b1e15e9835c73497e6185&limit=10&offset=0&q=mot+nha

class WebService: NSObject {
    func getURLSerchName(name:String, limit:Int, offset:Int, completion: APIControllerCallBack) {
        let parameter: [String: AnyObject] = ["client_id": Key.clientId,
                                              "q": name,
                                              "limit": limit,
                                              "offset": offset]
        Alamofire.request(.GET, APISearch.baseURL + APISearch.search, parameters: parameter, encoding: .URLEncodedInURL, headers: nil)
            .responseJSON { response in
                print(response)
                if let JSON = response.result.value as? [String: AnyObject] {
                    let result = JSON["collection"] as? [AnyObject]
                    completion(success: true, result: result, error: nil)
                }
        }
    }
}


