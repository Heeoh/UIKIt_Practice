//
//  SearchBarView.swift
//  OHouseHomePractice
//
//  Created by Heeoh Son on 11/29/24.
//

import Foundation
import UIKit

class SearchBarView: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    
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
        self.view.layer.cornerRadius = 8
    }
    
    func applyCustomStyle(placeHolderText: String = "검색어를 입력하세요") {
        self.textField.placeholder = placeHolderText
    }
    
    private func applyAction() {
        
    }
}
