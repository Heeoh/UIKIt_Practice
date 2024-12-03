//
//  IconButton.swift
//  OHouseHomePractice
//
//  Created by Heeoh Son on 11/29/24.
//

import Foundation
import UIKit

class IconButton: UIView {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var iconImg: UIImageView!
    
    var buttonTapAction: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyDefaultStyle()
        self.applyAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        self.applyNib()
        self.applyDefaultStyle()
        self.applyAction()
    }
    
    fileprivate func applyNib() {
        let nibName = String(describing: Self.self)
        let nib = Bundle.main.loadNibNamed(nibName, owner: self)
        guard let view = nib?.first as? UIView else {
            return
        }
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func applyDefaultStyle() {
        
    }
    
    func applyCustomStyle(iconImg: UIImage?,
                          iconColor: UIColor = .black,
                          backgroundColor: UIColor = .clear) {
        self.iconImg.image = iconImg ?? UIImage(systemName: "questionmark.square")
        self.iconImg.tintColor = iconColor
        self.button.backgroundColor = backgroundColor
    }
    
    private func applyAction() {
        self.button.addAction(UIAction(handler: { _ in
            self.buttonTapAction()
        }), for: .touchUpInside)
    }
    
    
}
