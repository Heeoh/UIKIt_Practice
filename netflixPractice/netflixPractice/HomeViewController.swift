//
//  HomeViewController.swift
//  netflixPractice
//
//  Created by Heeoh Son on 12/3/24.
//

import UIKit

/// 대표 콘텐츠 카드 뷰
/// 홈 뷰 상단에 나타남, 넷플릭스 대표 컨텐츠
class mainContentCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyDefaultStyle()
        self.applyAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        self.applyDefaultStyle()
        self.applyAction()
    }
    
    private func applyDefaultStyle() {
        self.layer.cornerRadius = 16
    }
    
    func applyCustomStyle() {
        
    }
    
    private func applyAction() {
        
    }
}


/// 홈 뷰
class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    /// 프로필 닉네임
    var nickname: String = ""
    
    /// 프로필 닉네임 라벨
    @IBOutlet weak var nicknameLabel: UILabel!
    
    /// 스크린 쉐어 버튼
    @IBOutlet weak var screenShareBtn: IconButtonView!
    
    /// 내가 저장한 콘텐츠 버튼
    @IBOutlet weak var downloadBtn: IconButtonView!
    
    /// 검색 버튼
    @IBOutlet weak var searchBtn: IconButtonView!
    
    /// 대표 컨텐츠 카드 버튼
    /// 클릭 시 해당 컨텐츠 뷰로 이동
    @IBOutlet weak var mainContentCardBtn: UIButton!
    
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(nickname: String = "nickname") {
        self.init(nibName: "HomeViewController", bundle: nil)
        self.nickname = nickname
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nicknameLabel.text = self.nickname + " 님"
        
        // set action on buttons in home header (screenShare, download, search button)
        screenShareBtn.applyCustomStyle(iconImg: UIImage(systemName: "tv.badge.wifi"), action: {
            print(#fileID, #function, #line, "- screen share btn clicked")
        })
        downloadBtn.applyCustomStyle(iconImg: UIImage(systemName: "arrow.down.to.line"), action: {
            print(#fileID, #function, #line, "- download btn clicked")
        })
        searchBtn.applyCustomStyle(iconImg: UIImage(systemName: "magnifyingglass"), action: {
            print(#fileID, #function, #line, "- search btn clicked")
        })
        
        // set main content car button action
        mainContentCardBtn.addAction(UIAction(handler: { _ in
            print(#fileID, #function, #line, "main content card clicked")
            let contentNavStack = self.makeContentNavStack()
            contentNavStack.pushViewController(ContentViewController(), animated: true)
            // print(#fileID, #function, #line, "\(contentNavStack.viewControllers.count)")
            self.present(contentNavStack, animated: true)
        }), for: .touchUpInside)
        
    }
    
    
    /// 홈 뷰에서 컨텐츠 클릭 시, 해당 컨텐츠 뷰 present 됨
    /// 해당 컨텐츠뷰를 루트뷰로 하는 네비게이션 컨트롤러 생성 함수
    /// - Returns: 컨텐츠 뷰를 포함한 네비게이션 컨트롤러
    fileprivate func makeContentNavStack() -> UINavigationController {
        let navStack = UINavigationController()
        navStack.modalPresentationStyle = .overCurrentContext
        navStack.isNavigationBarHidden = true
        return navStack
    }

}


// MARK: Preview
#if DEBUG

import SwiftUI

@available(iOS 17, *)
#Preview {
    HomeViewController(nickname: "hio")
}

struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        HomeViewController(nickname: "hio")
    }
}

struct HomeViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        HomeViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

#endif
