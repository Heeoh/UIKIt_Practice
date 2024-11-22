//
//  ViewController.swift
//  OHouseSignUpPractice
//
//  Created by Heeoh Son on 11/13/24.
//

import UIKit

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
              
        emailInputView.applyCustomLayout(placeholder: "이메일", isRequired: true)
        passwordInputView.applyCustomLayout(placeholder: "비밀번호", isRequired: true)
        passwordCheckInputView.applyCustomLayout(placeholder: "비밀번호 확인", isRequired: true)
        nicknameInputView.applyCustomLayout(placeholder: "닉네임 (중복 불가)", isRequired: false)
        
        emailVerifyButton.applyCustomLayout(titleLabel: "이메일 인증하기", style: .ghost, isActive: false)
        emailVerifyButton.button.addTarget(self, action: #selector(handleVerifyButtonClicked), for: .touchUpInside)
        
        signUpButton.applyCustomLayout(titleLabel: "회원가입 완료", style: .solid, isActive: false)
        signUpButton.button.addTarget(self, action: #selector(handleVerifyButtonClicked), for: .touchUpInside)
        
    }
}

extension ViewController {
    @objc func handleVerifyButtonClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "sender: \(String(describing: sender))")
    }
}
