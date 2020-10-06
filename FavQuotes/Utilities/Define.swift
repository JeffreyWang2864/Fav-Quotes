//
//  Define.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let PHONE_TYPE: FQPhoneType = {
    assert(UIDevice().userInterfaceIdiom == .phone)
    switch UIScreen.main.nativeBounds.height {
    case 1136:
        return .iphonese
    case 1334:
        return .iphone8
    case 1920, 2208:
        return .iphone8plus
    case 1792:
        return .iphone11
    case 2436:
        return .iphone11pro
    case 2688:
        return .iphone11promax
    default:
        fatalError()
    }
}()
