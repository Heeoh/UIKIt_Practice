//
//  IconButtonView.swift
//  netflixPractice
//
//  Created by Heeoh Son on 12/3/24.
//

import Foundation
import UIKit

/// 커스텀 아이콘 버튼
class IconButtonView: UIView {
    
    // MARK: - Properties
    
    /// 아이콘 이미지
    @IBOutlet weak var iconImg: UIImageView!
    
    /// 버튼 부분
    @IBOutlet weak var button: UIButton!
    
    /// 클릭 시 실행되는 액션
    var action: (() -> Void)? = nil
    
    // MARK: - Init
    
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
    
    
    // MARK: - Setting
    
    /// 공통적으로 적용되는 스타일
    private func applyDefaultStyle() {
        // print(#fileID, #function, #line, "")
    }
    
    /// 커스텀 스타일 적용
    /// - Parameters:
    ///   - iconImg: 아이콘 이미지 (UIImage)
    ///   - iconColor: 아이콘 이미지 tint color
    ///   - action: 클릭 액션
    func applyCustomStyle(iconImg: UIImage?,
                          iconColor: UIColor = .white,
                          action: (() -> Void)?) {
        self.iconImg.image = iconImg?.withRenderingMode(.alwaysTemplate)
        self.iconImg.tintColor = iconColor
        self.action = action
    }
    
    /// 액션 적용
    private func applyAction() {
        button.addAction(UIAction(handler: { _ in
            self.action?()
        }), for: .touchUpInside)
    }
}
