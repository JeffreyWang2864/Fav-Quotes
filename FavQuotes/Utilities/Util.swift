//
//  Util.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class Util{
    private init(){}
    public static func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat{
        let label: UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    public static func isAppFirstTimeLaunched() -> Bool {
        let userDefault = UserDefaults.standard
        if let _ = userDefault.string(forKey: "isAppFirstTimeLaunched") {
            return false
        } else {
            userDefault.set(true, forKey: "isAppFirstTimeLaunched")
            return true
        }
    }
}
