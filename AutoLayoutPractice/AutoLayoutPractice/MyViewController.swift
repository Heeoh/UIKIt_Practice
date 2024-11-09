//
//  MyViewController.swift
//  AutoLayoutPractice
//
//  Created by Heeoh Son on 10/18/24.
//

import Foundation
import UIKit

class MyViewController: UIViewController {

    @IBOutlet var homeBanner: UIView!
    @IBOutlet var QnACardView: CustomCardView!
    @IBOutlet var simpleQnACardView: CustomCardView!
    @IBOutlet var ImageCardList: CustomCardView!
    @IBOutlet var imageCard1: CustomCardView!
    @IBOutlet var imageCard2: CustomCardView!
    @IBOutlet var imageCard3: CustomCardView!
    
    @IBOutlet var dosage1: RoundedView!
    @IBOutlet var dosage2: RoundedView!
    
    @IBOutlet var proileImageView: RoundedView!
    
    @IBOutlet var productReviewCard: CustomCardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeBanner.layer.cornerRadius = 16
        
        QnACardView.cornerRadius = 20
        QnACardView.hasShadow = true
        
        simpleQnACardView.cornerRadius = 20
        simpleQnACardView.hasShadow = true
        
        ImageCardList.cornerRadius = 20
        ImageCardList.hasShadow = true
        
        imageCard1.cornerRadius = 16
        imageCard1.hasShadow = true
        imageCard2.cornerRadius = 16
        imageCard2.hasShadow = true
        imageCard3.cornerRadius = 16
        imageCard3.hasShadow = true
        
        dosage1.cornerRadius = dosage1.frame.height / 2
        dosage2.cornerRadius = dosage2.frame.height / 2
     
        proileImageView.isCircle = true
        
        productReviewCard.cornerRadius = 20
        productReviewCard.hasShadow = true
    }
}

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            if isCircle && isSquare{
                self.cornerRadius = self.frame.width / 2
            } else if isCircle {
                print("Error: is not square")
            }
        }
    }
    
    fileprivate var isSquare: Bool {
        return self.frame.width == self.frame.height
    }
    
}
