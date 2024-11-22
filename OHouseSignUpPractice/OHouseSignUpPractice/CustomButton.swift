//
//  CustomButton.swift
//  OHouseSignUpPractice
//
//  Created by Heeoh Son on 11/21/24.
//

import Foundation
import UIKit


/// 커스텀 버튼 스타일
enum ButtonStyle: Int {
    case solid = 0
    case ghost = 1
}

/// 커스텀 버튼
@IBDesignable
class CustomButton: UIView {
    
    // MARK: properties

    @IBOutlet weak var button: UIButton!
    
    /// inactive 상태 시에 사용되는 가림막 뷰,
    /// solid 상태일 때는 버튼을 불투명하게 보이게 함
    @IBOutlet weak var opacityView: UIView!

//    private var solidActiveConfig = UIButton.Configuration.filled()
//    private var solidInactiveConfig = UIButton.Configuration.tinted()
//    
//    private var ghostActiveConfig = UIButton.Configuration.plain()
//    private var ghostInactiveConfig = UIButton.Configuration.gray()
//    
//    var titleAttr = AttributedString.init("Button")
    
    
    /// 버튼 스타일 - solid, ghost
    /// 버튼 스타일이 설정되면 해당 타입에 맞게 스타일을 적용
    var buttonStyle: ButtonStyle = .solid {
        didSet {
            applyStyle(for: buttonStyle)
        }
    }
    
    /// inspectable에서의 버튼 스타일 설정을 도와주는 어댑터
    @IBInspectable var buttonStyleAdapter: Int {
        get {
            return self.buttonStyle.rawValue
        }
        set ( styleIdx) {
            self.buttonStyle = ButtonStyle(rawValue: styleIdx) ?? .solid
        }
    }
    
    /// 버튼 활성화 상태
    /// 활성화 상태가 바뀌면 현재 상태에 맞게 버튼 스타일을 적용
    @IBInspectable var isActive: Bool = true {
        didSet {
            guard let button = self.button else {
                return
            }
            guard let opacityView = self.opacityView else {
                return
            }
            
            button.isEnabled = isActive
            opacityView.isHidden = isActive ? true : false
            self.applyStyle(for: self.buttonStyle)
        }
    }
    
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyNib()
        self.applyDefaultLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        self.applyNib()
        self.applyDefaultLayout()
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
    
    /// 모든 버튼 스타일에 공통적으로  적용되는 디자인
    /// & 버튼 스타일 초기화
    private func applyDefaultLayout() {
        self.button.layer.cornerRadius = 4
        self.button.layer.borderWidth = 1
        self.button.backgroundColor = .clear
        self.button.tintColor = .clear
        self.opacityView.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    /// 사용자가 커스텀한 버튼 스타일에 맞게 디자인 적용
    /// - Parameters:
    ///   - titleLabel: 버튼 타이틀 라벨 (버튼 텍스트)
    ///   - style: 버튼 스타일 (solid, ghost)
    ///   - isActive: 버튼 초기 활성화 상태
    func applyCustomLayout(titleLabel: String = "",
                           style: ButtonStyle = .solid,
                           isActive: Bool = true) {
        
        
        self.button.setTitle(titleLabel, for: .normal)
        self.buttonStyle = style
        self.isActive = isActive
        
        self.applyStyle(for: style)
    }
    
    /// 버튼 스타일에 따라 디자인 적용
    /// - Parameter style: 적용할 버튼 스타일
    private func applyStyle(for style: ButtonStyle) {
        // print(#fileID, #function, #line, "style: \(style), active: \(self.isActive)")
        
        guard let button = self.button else { return }
        guard let opacityView = self.opacityView else { return }
        
        switch style {
        case .solid:
            if isActive {
                button.backgroundColor = .systemMint
                button.layer.borderColor = UIColor.systemMint.cgColor
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemMint
                button.layer.borderColor = UIColor.systemMint.cgColor
                button.setTitleColor(.white, for: .disabled)
                opacityView.backgroundColor = UIColor(white: 1, alpha: 0.5)
            }
        case .ghost:
            if isActive {
                button.backgroundColor = .white
                button.layer.borderColor = UIColor.systemMint.cgColor
                button.setTitleColor(.systemMint, for: .normal)
            } else {
                button.backgroundColor = .systemGray5
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.setTitleColor(.lightGray, for: .disabled)
                opacityView.backgroundColor = .clear
            }
        }
    }
}
