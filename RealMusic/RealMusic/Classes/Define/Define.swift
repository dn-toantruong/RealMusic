//
//  Define.swift
//  RealMusic
//
//  Created by asiantech on 8/25/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import Foundation
import UIKit
//api.soundcloud.com/search?client_id=97effc2d5a8b1e15e9835c73497e6185&limit=10&offset=0&q=mot+nha
struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE = UIDevice.currentDevice().userInterfaceIdiom == .Phone
    static let IS_IPAD = UIDevice.currentDevice().userInterfaceIdiom == .Pad
}

struct APISearch {
    static let baseURL = "https://api.soundcloud.com/"
    static let search = "search?"
}

struct Key {
    static let clientId = "97effc2d5a8b1e15e9835c73497e6185"
}

// MARK: - ALERT BUTTON
let ALERT_BUTTON_DEFAULT = "OK"
