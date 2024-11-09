//
//  CustomCardView.swift
//  AutoLayoutPractice
//
//  Created by Heeoh Son on 10/18/24.
//

import Foundation
import UIKit

@IBDesignable
class CustomCardView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var hasShadow: Bool = false {
        didSet {
            self.layer.applyShadow(alpha: 0.1, y: 6, blur: 20)
        }
    }
}
