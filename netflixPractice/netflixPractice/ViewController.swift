//
//  ViewController.swift
//  netflixPractice
//
//  Created by Heeoh Son on 12/3/24.
//

import UIKit


/// 넷플릭스 프로필 선택 페이지
class ViewController: UIViewController {
    
    /// 넷플릭스 프로필 버튼
    @IBOutlet weak var profileBtn: UIButton!
    
    /// 프로필 닉네임 라벨
    @IBOutlet weak var nicknameLabel: UILabel!
    
    /// 프로필 닉네임 스트링
    var nickname : String = "" {
        didSet {
            nicknameLabel.text = nickname
        }
    }
    
    /// 메인 네비게이션 스택
    /// 프로필 버튼 클릭 시 present 됨
    let mainNavStack: UINavigationController = {
        let nav = UINavigationController()
        nav.modalPresentationStyle = .overCurrentContext
        nav.modalTransitionStyle = .crossDissolve
        nav.isNavigationBarHidden = true
        return nav
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get profile nickname
        self.nickname = "hio"
        
        // set profile button action
        profileBtn.addAction(UIAction(handler: { _ in
            self.mainNavStack.pushViewController(HomeViewController(nickname: "hio"), animated: false)
            self.present(self.mainNavStack, animated: false)
        }), for: .touchUpInside)
    }
}


// MARK: - Preview
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
