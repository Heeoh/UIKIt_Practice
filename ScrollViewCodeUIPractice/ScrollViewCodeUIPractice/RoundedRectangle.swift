//
//  RoundedRectangle.swift
//  ScrollViewCodeUIPractice
//
//  Created by Heeoh Son on 11/1/24.
//

import Foundation
import UIKit

class RoundedRectangle: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(cornerRadius: CGFloat) {
        self.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // func makeCircle() {}
}
