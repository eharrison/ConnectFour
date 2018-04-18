//
//  UIColorExtensions.swift
//  ConnectFour
//
//  Created by Evandro Harrison Hoffmann on 4/16/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func color(hexString hex: String?) -> UIColor? {
        guard let hex = hex else {
            return nil
        }
        
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count == 6) {
            return colorWithoutAlpha(cString: cString)
        } else if cString.count == 8 {
            return colorWithAlpha(cString: cString)
        }
        
        return UIColor.gray
    }
    
    static func colorWithoutAlpha(cString: String) -> UIColor? {
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    static func colorWithAlpha(cString: String) -> UIColor? {
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        let aString = ((cString as NSString).substring(from: 6) as NSString).substring(to: 2)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0, a: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        Scanner(string: aString).scanHexInt32(&a)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }
}

extension String {
    var uiColor: UIColor? {
        return UIColor.color(hexString: self)
    }
}
