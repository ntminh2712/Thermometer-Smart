//
//  CardView.swift
//  BabyCare
//
//  Created by HOANDHTB on 9/9/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit

import UIKit
@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.black

    @IBInspectable var shadowOffSetWidth: Int = 0
    @IBInspectable var shadowOffSetHeight: Int = 0

    @IBInspectable var shadowOpacity: Float = 0.3

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
}

