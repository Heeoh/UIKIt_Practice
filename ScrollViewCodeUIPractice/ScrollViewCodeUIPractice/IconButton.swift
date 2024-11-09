//
//  IconButton.swift
//  ScrollViewCodeUIPractice
//
//  Created by Heeoh Son on 11/7/24.
//

import Foundation
import UIKit

class IconButton: UIView {
    
    private let button: UIButton
    
    override init(frame: CGRect) {
        self.button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        super.init(coder: coder)
    }
    
    convenience init(icon: UIImage?,
                     iconSize: CGSize = CGSize(width: 24, height: 24),
                     padding: UIEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6),
                     bgColor: UIColor = .clear,
                     tintColor: UIColor = .cyan) {
        self.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setLayout(icon: icon, iconSize: iconSize, padding: padding, bgColor: bgColor, tintColor: tintColor)
    }
    
    private func setLayout(icon: UIImage?,
                           iconSize: CGSize,
                           padding: UIEdgeInsets,
                           bgColor: UIColor,
                           tintColor: UIColor) {
        
        let iconImage : UIImageView = {
            let icon = UIImageView(image: icon)
            icon.translatesAutoresizingMaskIntoConstraints = false
            
            icon.widthAnchor.constraint(equalToConstant: iconSize.width).isActive = true
            icon.heightAnchor.constraint(equalToConstant: iconSize.height).isActive = true
            icon.contentMode = .scaleAspectFit
            
            icon.backgroundColor = .clear
            icon.tintColor = tintColor
            
            return icon
        }()
                
        self.backgroundColor = bgColor
        
        self.addSubview(iconImage)
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.top),
            iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding.bottom),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.left),
            iconImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding.right),
            
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    func setAction(target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
        self.button.addTarget(target, action: action, for: controlEvents)
    }
}

//class ToggledIconButton: IconButton {
//    init(defaultIcon: UIImage,
//         subIcon: UIImage? = nil,
//         iconSize: CGSize = CGSize(width: 24, height: 24),
//         padding: UIEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6),
//         bgColor: UIColor = .clear,
//         defaultTintColor: UIColor = .cyan,
//         subTintColor: UIColor? = nil) {
//        super.init(icon: defaultIcon,
//                   iconSize: iconSize,
//                   padding: padding,
//                   bgColor: bgColor,
//                   tintColor: defaultTintColor)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
