//
//  FQView.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class FQView: UIView{
    var roundCorners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]{
        didSet{
            self.layoutSubviews()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: self.roundCorners, cornerRadii: CGSize(width: 10, height: 10))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
