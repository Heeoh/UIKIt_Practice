//
//  UIColor+Ext.swift
//  netflixPractice
//
//  Created by Heeoh Son on 12/6/24.
//

import Foundation
import UIKit

extension UIColor {
    /// 랜덤 컬러 생성
    /// - Returns: 랜덤으로 생성된 UIColor
    class func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
}
