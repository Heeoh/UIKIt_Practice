//
//  ContentViewController.swift
//  netflixPractice
//
//  Created by Heeoh Son on 12/6/24.
//

import Foundation
import UIKit

/// 컨텐츠 뷰
class ContentViewController: UIViewController {
    
    // MARK: - Properties
    
    /// 네비게이션 뒤로 가기 버튼
    @IBOutlet weak var backBtn: IconButtonView!
    
    /// 컨텐츠 바텀시트 dismiss 버튼
    @IBOutlet weak var closeBtn: IconButtonView!
    
    /// 컨텐츠뷰(self)가 포함된 부모 네비게이션 컨트롤러
    var parentNav: UINavigationController? = nil
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parentNav = self.parent as? UINavigationController
        
        // for navigation test
        self.view.layer.backgroundColor = UIColor.randomColor().cgColor
        
        // set close button
        closeBtn.applyCustomStyle(iconImg: UIImage(systemName: "x.circle.fill"),
                                  iconColor: .darkGray,
                                  action: {
            self.dismiss(animated: true)
            // self.navStack.popToRootViewController(animated: false)
        })
        
        // set navigation back button
        if parentNav?.viewControllers.first === self {
            // 첫 번째 뷰컨이면, 백 버튼 숨기기
            backBtn.isHidden = true
        } else {
            backBtn.applyCustomStyle(iconImg: UIImage(systemName: "chevron.left.circle.fill"),
                                     iconColor: .darkGray,
                                     action: {
                self.parentNav?.popViewController(animated: true)
            })
        }
        
    }
}

// for test action
extension ContentViewController {
    @IBAction func pushTestBtnAction(_ sender: Any) {
        self.parentNav?.pushViewController(ContentViewController(), animated: true)
        print(#fileID, #function, #line, "push test - \(self.parentNav?.viewControllers.count ?? 0)")
    }
    
    
}


// MARK: Preview

#if DEBUG

import SwiftUI

@available(iOS 17, *)
#Preview {
    return ContentViewController()
}

struct ContentViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ContentViewController()
    }
}

struct ContentViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ContentViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

#endif

