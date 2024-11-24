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
     [ ] 이메일 형식이 유효하면 이메일 인증하기 버튼 활성화시키기
     [ ] 이메일 인증하기 클릭 시 로딩 뷰 보이기
     [ ] 이메일 인증 중에 이메일 입력값이 바뀌면 인증 상태 취소
        - 취소 후 인증하기 버튼 활성화 상태는 입력값 유효 여부에 따름
     [ ] 이메일 인증이 완료되면 이메일 인증 완료로 버튼 텍스트 변경 후 비활성화, 이메일 입력퓨도 비활성화
 [ ] 비밀번호
 
 
 
 
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
