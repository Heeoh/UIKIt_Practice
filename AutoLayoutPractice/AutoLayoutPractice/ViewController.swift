//
//  ViewController.swift
//  AutoLayoutPractice
//
//  Created by Heeoh Son on 10/14/24.
//

import Foundation
import UIKit

extension CALayer {
    
    /// view layer에 shadow 적용
    /// - Parameters:
    ///   - color: 색상
    ///   - alpha: 투명도
    ///   - x: x 위치
    ///   - y: y 위치
    ///   - blur: 번짐 정도
    ///   - spread: 퍼짐 정도
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.25,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 8,
        spread: CGFloat = 0)
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var homeBanner: UIView!
    
    @IBOutlet var tappedOptionTag: CustomOptionTagView!
    @IBOutlet var optionTag : CustomOptionTagView!
    @IBOutlet var optionTag2: CustomOptionTagView!
    
    @IBOutlet var rankingTileImageBg: CustomImageCardView!
    @IBOutlet var rankingTileImageBg2: CustomImageCardView!
    @IBOutlet var rankingTileImageBg3: CustomImageCardView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeBanner.layer.cornerRadius = 16
        
        tappedOptionTag.cornerRadius = 20
        tappedOptionTag.isTapped = true
        optionTag.cornerRadius = 20
        optionTag.isTapped = false
        optionTag2.cornerRadius = 20
        optionTag2.isTapped = false
        
        rankingTileImageBg.cornerRadius = 16
        rankingTileImageBg.hasShadow = true
        rankingTileImageBg2.cornerRadius = 16
        rankingTileImageBg2.hasShadow = true
        rankingTileImageBg3.cornerRadius = 16
        rankingTileImageBg3.hasShadow = true
        
    }


}

@IBDesignable
class CustomOptionTagView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var isTapped: Bool = false {
        didSet {
            if !isTapped {
                self.borderWidth = 1
                self.borderColor = UIColor.lightGray
            } else {
                self.borderWidth = 0
                self.borderColor = UIColor.clear
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class CustomImageCardView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var hasShadow: Bool = false {
        didSet {
            self.layer.applyShadow(alpha: 0.1, y: 8, blur: 20)
        }
    }
}
