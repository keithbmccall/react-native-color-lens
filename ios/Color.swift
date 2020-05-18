//
//  Color.swift
//  ColorLens
//
//  Created by Keith McCall on 5/10/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation

@objc(Color)
public class Color: NSObject {
    public var r: UInt8
    public var g: UInt8
    public var b: UInt8

    init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }

    public func getColors() -> Dictionary<String,UInt8> {
        return ["r":r , "g":g, "b":b]
    }
    public func makeUIColor() -> UIColor {
        return UIColor(red: CGFloat(r) / CGFloat(255), green: CGFloat(g) / CGFloat(255), blue: CGFloat(b) / CGFloat(255), alpha: CGFloat(1))
    }
}
