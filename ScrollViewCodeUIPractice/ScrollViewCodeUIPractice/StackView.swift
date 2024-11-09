//
//  StackView.swift
//  ScrollViewCodeUIPractice
//
//  Created by Heeoh Son on 11/1/24.
//

import Foundation
import UIKit

class StackView: UIStackView {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(axis: NSLayoutConstraint.Axis,
         distribution: UIStackView.Distribution = .fill,
         alignment: UIStackView.Alignment = .fill,
         spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func setPadding(top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
    
    func setPadding(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    func setPadding(_ padding: CGFloat) {
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
    }
}

class HStack: StackView {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (distribution: UIStackView.Distribution = .fill,
          alignment: UIStackView.Alignment = .fill,
          spacing: CGFloat = 0) {
        super.init(axis: .horizontal, distribution: distribution, alignment: alignment, spacing: spacing)
    }
}

class VStack: StackView {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(distribution: UIStackView.Distribution = .fill,
         alignment: UIStackView.Alignment = .fill,
         spacing: CGFloat = 0) {
        super.init(axis: .vertical, distribution: distribution, alignment: alignment, spacing: spacing)
    }
}
