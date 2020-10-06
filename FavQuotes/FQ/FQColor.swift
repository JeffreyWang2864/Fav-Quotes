//
//  FQColor.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class FQColor{
    public static let themeColor = FQColor.convert(from: 0xFF4659, alpha: 1.0)
    public static let dayBackgroundColor = FQColor.convert(from: 0xF0F0F5, alpha: 1.0)
    public static let dayForegroundColor = FQColor.convert(from: 0xFFFFFF, alpha: 1.0)
//    public static let nightBackgroundColor = FQColor.convert(from: 0x000000, alpha: 1.0)
//    public static let nightForegroundColor = FQColor.convert(from: 0x1A1A1C, alpha: 1.0)
    
    public static func convert(from rgbValue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0, alpha: alpha)
    }
}
