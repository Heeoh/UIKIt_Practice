//
//  CustomInputView.swift
//  OHouseSignUpPractice
//
//  Created by Heeoh Son on 11/14/24.
//

import Foundation
import UIKit

/* TODO
[V] 텍스트필드에 포커싱 인, 아웃 액션 연결
[V] 텍스트 필드 입력값이 바뀌면
    [V] 입력 값이 있다면 -> x 버튼 보이기
    [V] validity 확인
[V] 포커싱 아웃 액션 시
    [V] validity 체크하기
    [V] 가입된 유저인지 확인
    [V] x 버튼 나와있다면 안보이게 하기
[V] invalid 처리
    [V] invalid -> 빨간 보더 & 에러 메시지 보이게 하기
    [V] valid -> 회색 보더 & 에러 메시지 숨기기
*/



/// CustomInputView에 이메일이 입력된 경우, 발생할 수 있는 입력값 에러
enum EmailInputErrorType: String {
    case emptyValue = "꼭 입력해야 해요."
    case invalidEmail = "이메일 형식에 맞는지 확인해주세요."
    case alreadyRegistered = "이미 가입한 이메일이에요."
    case notRegistered = "가입되지 않은 이메일이에요."
}

/// CustomInputView에 비밀번호가 입력된 경우, 발생할 수 있는 입력값 에러
enum PasswordInputErrorType: String {
    case emptyValue = "꼭 입력해야 해요."
    case invalidPassword = "영문, 숫자를 포함해 8자 이상으로 만들어주세요."
    case emptyCheckerValue = "확인을 위해 비밀번호를 한번 더 입력해주세요."
    case wrongChecker = "비밀번호가 일치하지 않아요."
}


enum InputViewState {
    case basic
    case error
    case inactive
}

/// 텍스트 입력 뷰
@IBDesignable
class CustomInputView: UIView {
    
    // MARK: Properties
    
    /// 텍스트필드
    @IBOutlet weak var inputTextField: UITextField!
    
    /// 텍스트 필드 입력값 전체 삭제 버튼
    @IBOutlet weak var removeButton: UIButton!
    
    /// 입력값이 유효하지 않을 경우 나타나는 에러 문구
    @IBOutlet weak var invalidInputErrorText: UILabel!
    
    /// 텍스트필드 trailing anchor = input view trailing + 8
    @IBOutlet weak var inputTextFieldTrailingToInputView: NSLayoutConstraint!
    
    /// 텍스트필드 trailing anchor = remove btn leading + 4
    @IBOutlet weak var inputTextFieldTrailingToRemoveBtn: NSLayoutConstraint!
    
    
    /// 입력값이 유효하지 않을 경우, 에러 메시지
    var inputErrorText: String = ""
    
    var delegate: CustomInputViewDelegate? = nil
    
    
    // MARK: State Properties
    
    /// 필수로 입력되어야 하는지 여부
//    private var isRequired: Bool = true

    /// 활성화 여부, 입력 가능한지 여부
    private var isActive: Bool = true {
        didSet {
            if !isActive {
                applyStyle(for: InputViewState.inactive)
            }
        }
    }

    /// 입력 중인지 여부
    private var isEditing: Bool = false {
        didSet {
            self.isRemoveBtnActive = isEditing && !isRemoveBtnHidden ? true : false
            
            print(#fileID, #function, #line, "\(isEditing), \(isRemoveBtnActive)")
        }
    }
    
    /// 입력값이 유효한지 여부
    var isValidInput: Bool = true {
        didSet {
            if isValidInput {
                applyStyle(for: InputViewState.basic)
                self.setInputErrorText(text: "")
            } else {
                applyStyle(for: InputViewState.error)
                self.setInputErrorText(text: inputErrorText)
            }
        }
    }
    
    private var isRemoveBtnHidden: Bool = false
    
    /// x 버튼 (입력값 전체 삭제) 활성화 여부
    private var isRemoveBtnActive: Bool = false {
        didSet {
            guard let anchorToInputView = self.inputTextFieldTrailingToInputView else { return }
            guard let anchorToRemoveBtn = self.inputTextFieldTrailingToRemoveBtn else { return }
            
            if isRemoveBtnActive {
                anchorToInputView.priority = UILayoutPriority(999)
                anchorToRemoveBtn.priority = UILayoutPriority(1000)
            } else {
                anchorToRemoveBtn.priority = UILayoutPriority(999)
                anchorToInputView.priority = UILayoutPriority(1000)
            }
        }
    }
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // print(#fileID, #function, #line, "")
        self.applyNib()
        self.applyDefaultLayout()
        self.applyAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // print(#fileID, #function, #line, "")
    }
    
    override func awakeFromNib() {
        // print(#fileID, #function, #line, "")
        self.applyNib()
        self.applyDefaultLayout()
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
    
    private func applyDefaultLayout() {
        self.isActive = true
        self.isEditing = false
        self.isValidInput = true
//        self.isRequired = true
        
        self.applyStyle(for: .basic)
        
        self.layer.borderWidth = 1
        // self.layer.cornerRadius = 8
        self.inputTextField.backgroundColor = UIColor.white
    }
    
    private func applyAction() {
        self.inputTextField.addTarget(self, action: #selector(handleTextFieldEditingBegin), for: .editingDidBegin)
        self.inputTextField.addTarget(self, action: #selector(handleTextFieldEditingEnd), for: .editingDidEnd)
        self.inputTextField.addTarget(self, action: #selector(handleTextFieldEditingChanged), for: .editingChanged)
        
        self.removeButton.addTarget(self, action: #selector(handleRemoveAllBtnClicked), for: .touchUpInside)
    }
    
    func applyCustomLayout(placeholder: String = "입력해주세요.", isSecureText: Bool = false, isActive: Bool = true, isRemoveBtnHidden: Bool = false) {
        print(#fileID, #function, #line, "")
        
        self.inputTextField.placeholder = placeholder
        if isSecureText {
            self.inputTextField.isSecureTextEntry = true
        }
        self.isActive = isActive
        self.isRemoveBtnHidden = isRemoveBtnHidden
        
    }
    
    /// input view 상태에 따라 디자인 스타일을 적용시켜줌
    /// - Parameter for: input view 상태
    private func applyStyle(for state: InputViewState) {
        switch state {
        case .basic:
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.backgroundColor = .white
        case .error:
            self.layer.borderColor = UIColor.red.cgColor
            self.backgroundColor = .white
        case .inactive:
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.backgroundColor = .lightGray
        }
    }
}

// MARK: handle input field interaction
extension CustomInputView {
    
    /// 텍스트필드 입력 종료 이벤트 발생 시 처리
    /// - Parameter sender: 이벤트가 발생한 텍스트필드
    @objc func handleTextFieldEditingEnd(_ sender: UITextField) {
        // print(#fileID, #function, #line, "- edit end: \(sender.text ?? "no input")")
        
        guard let input = sender.text else {
            self.isEditing = false
            self.isValidInput = false
            return
        }
        
        self.isEditing = false
        
        self.delegate?.inputDidEndEditing(in: self, newValue: input)
    }
    
    /// 텍스트필드 입력값 변경 이벤트 발생 시 처리
    /// - Parameter sender: 이벤트가 발생한 텍스트필드
    @objc func handleTextFieldEditingChanged(_ sender: UITextField) {
        // print(#fileID, #function, #line, "- edit changed: \(sender.text ?? "no input")")
        
        guard let input = sender.text else {
            self.isEditing = false
            self.isValidInput = false
            return
        }
        
        self.isEditing = input == "" ? false : true
        
        self.delegate?.inputDidChange(in: self, newValue: input)
    }
    
    /// 텍스트필드 입력 시작이벤트 발생 시 처리
    /// - Parameter sender: 이벤트가 발생한 텍스트필드
    @objc func handleTextFieldEditingBegin(_ sender: UITextField) {
        self.isEditing = true
    }
    
    /// 입력값 설정
    /// - Parameter newInput: 변경할 입력값
    fileprivate func setInputText(_ newInput: String) {
        self.inputTextField.text = newInput
    }
    
}


// MARK: handle remove button interaction
extension CustomInputView {
    
    /// x 버튼 클릭 이벤트 발생 시 처리,
    /// 입력값 전체 삭제, 빈문자열로 초기화
    /// - Parameter sender: 이벤트가 발생한 x 버튼
    @objc func handleRemoveAllBtnClicked(_ sender: UIButton) {
        // print(#fileID, #function, #line, "- \(self.inputTextField.text ?? "")")
        
        self.setInputText("")
        self.isEditing = false
        self.isValidInput = self.delegate?.validateInput(of: self, input: "") ?? true
    }
}
    
    
// MARK: handle input error text interaction
extension CustomInputView {
    
    /// 입력값 에러 메시지를 설정
    /// 에러 메시지가 없을 경우, 에러메시지 라벨을 안보이게 함
    /// - Parameter text: 에러 메시지
    fileprivate func setInputErrorText(text: String) {
        guard let errorText = self.invalidInputErrorText else {
            return
        }
        
        DispatchQueue.main.async {
            errorText.text = text
        }
        errorText.isHidden = text == "" ? true : false
    }
}


