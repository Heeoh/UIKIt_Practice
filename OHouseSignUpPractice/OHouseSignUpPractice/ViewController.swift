//
//  ViewController.swift
//  OHouseSignUpPractice
//
//  Created by Heeoh Son on 11/13/24.
//

import UIKit

/*
 TODO
 [ ] 이메일
    [V] 유효 검사
    [ ] 이메일 형식이 유효하면 이메일 인증하기 버튼 활성화시키기
    [ ] 이메일 인증하기 클릭 시 로딩 뷰 보이기
    [ ] 이메일 인증 중에 이메일 입력값이 바뀌면 인증 상태 취소
        - 취소 후 인증하기 버튼 활성화 상태는 입력값 유효 여부에 따름
    [ ] 이메일 인증이 완료되면 이메일 인증 완료로 버튼 텍스트 변경 후 비활성화, 이메일 입력퓨도 비활성화
 [V] 비밀번호, 비밀번호 확인 유효검사
 
 */
 
class ViewController: UIViewController {

    @IBOutlet weak var emailInputView: CustomInputView!
    
    @IBOutlet weak var passwordInputView: CustomInputView!
    
    @IBOutlet weak var passwordCheckInputView: CustomInputView!
    
    @IBOutlet weak var nicknameInputView: CustomInputView!
    
    @IBOutlet weak var emailVerifyButton: CustomButton!
    
    @IBOutlet weak var signUpButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
              
        self.setCustomView()
        self.setAction()
        
    }
    
    private func setCustomView() {
        emailInputView.applyCustomLayout(placeholder: "이메일")
        passwordInputView.applyCustomLayout(placeholder: "비밀번호", isSecureText: true)
        passwordCheckInputView.applyCustomLayout(placeholder: "비밀번호 확인", isSecureText: true)
        nicknameInputView.applyCustomLayout(placeholder: "닉네임 (중복 불가)")
        
        emailVerifyButton.applyCustomLayout(titleLabel: "이메일 인증하기", style: .ghost, isActive: true)
        
        signUpButton.applyCustomLayout(titleLabel: "회원가입 완료", style: .solid, isActive: false)
    }
    
    private func setAction() {
        self.setInputViewDelegate()
        
        emailVerifyButton.btnTapAction = {
            print(#fileID, #function, #line, "- email verify btn tapped")
        }
        
        signUpButton.btnTapAction = {
            print(#fileID, #function, #line, "- sign up btn tapped")
        }
    }
}

extension ViewController: CustomInputViewDelegate {
    
    func inputDidEndEditing(in inputView: CustomInputView, newValue: String) {
        inputView.isValidInput = self.validateInput(of: inputView, input: newValue)
        
        print(#fileID, #function, #line, "newValue: \(newValue), isValid: \(inputView.isValidInput)")
    }
    
    func inputDidChange(in inputView: CustomInputView, newValue: String) {
        if !inputView.isValidInput {
            inputView.isValidInput = self.validateInput(of: inputView, input: newValue)
            
            print(#fileID, #function, #line, "newValue: \(newValue), isValid: \(inputView.isValidInput)")
        }
    }
    
    func validateInput(of inputView: CustomInputView, input: String) -> Bool {
        if inputView === emailInputView {
            let errorType = self.validateEmail(email: input)
            inputView.inputErrorText = errorType?.rawValue ?? ""
            return errorType == nil ? true : false
        }
        
        else if inputView === passwordInputView {
            let errorType = self.validatePassword(password: input)
            inputView.inputErrorText = errorType?.rawValue ?? ""
            return errorType == nil ? true : false
        }
        
        else if inputView === passwordCheckInputView {
            let errorType = self.validatePasswordChecker(checker: input)
            inputView.inputErrorText = errorType?.rawValue ?? ""
            return errorType == nil ? true : false
        }
        
        else if inputView === nicknameInputView {
            return true
        }
        
        return true
    }
    
    
    private func setInputViewDelegate() {
        emailInputView.delegate = self
        passwordInputView.delegate = self
        passwordCheckInputView.delegate = self
        nicknameInputView.delegate = self
    }
    
    /// 이메일이 유효한지 검사
    /// 유효하지 않다면,  이메일 에러 타입을 리턴
    /// - Parameter email: 입력값
    /// - Returns: 이메일 에러 타입을 리턴, 유효하다면 nil을 리턴
    private func validateEmail(email: String) -> EmailInputErrorType? {
        // 입력값이 있는지 확인
        if email == ""{
            return EmailInputErrorType.emptyValue
        }
        
        // 이메일 형식 확인
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z]{2,}(?:\\.[a-zA-Z]{2,})*$"
        if !email.matchesRegex(emailRegex) {
            return EmailInputErrorType.invalidEmail
        }
        
        // 이메일 중복 확인
        // TODO: api로 가입한 이메일인지 확인
        let isAlreadyRegistered = false
        if isAlreadyRegistered {
            return EmailInputErrorType.alreadyRegistered
        }
        
        return nil
    }
    
    /// 비밀번호가 유효한지 검사
    /// 유효하지 않다면,  비밀번호 에러 타입을 리턴
    /// - Parameter password: 입력값
    /// - Returns: 비밀번호 에러 타입을 리턴, 유효하다면 nil을 리턴
    private func validatePassword(password: String) -> PasswordInputErrorType? {
        // 입력값이 있는지 확인
        if password == ""{
            return PasswordInputErrorType.emptyValue
        }
        
        // 비밀번호 형식 확인
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d).{8,}$"
        if !password.matchesRegex(passwordRegex) {
            return PasswordInputErrorType.invalidPassword
        }
        
        return nil
    }
    
    /// 비밀번호 확인 입력값이 유효한지 검사
    /// 유효하지 않다면,  비밀번호 에러 타입을 리턴
    /// - Parameter password: 입력값
    /// - Returns: 비밀번호 에러 타입을 리턴, 유효하다면 nil을 리턴
    private func validatePasswordChecker(checker: String) -> PasswordInputErrorType? {
        // 입력값이 있는지 확인
        if checker == ""{
            return PasswordInputErrorType.emptyCheckerValue
        }
        
        // 비밀번호와 일치하는지 확인
        if passwordInputView.inputTextField.text != checker {
            return PasswordInputErrorType.wrongChecker
        }
        
        return nil
    }
    
}



#if DEBUG

import SwiftUI

extension ViewController {
    /// iOS 17 이상일 때, previewProvider를 사용하기 위해 VC instance를 만드는 팩토리 메소드
    class func makeInstance() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateInitialViewController() as! ViewController
    }
}
    
@available(iOS 17, *)
#Preview {
    return ViewController.makeInstance()
}


/// swiftUI를 이용해 preview를 사용하기 위한 UIViewControllerRepresentable
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
}

struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
            .ignoresSafeArea()
    }
}


#endif
