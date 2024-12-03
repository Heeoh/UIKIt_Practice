//
//  ViewController.swift
//  OHouseHomePractice
//
//  Created by Heeoh Son on 11/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoryBtn: IconButton!
    
    @IBOutlet weak var alarmBtn: IconButton!
    
    @IBOutlet weak var bookmarkBtn: IconButton!
    
    @IBOutlet weak var cartBtn: IconButton!
    
    
    @IBOutlet weak var searchBar: SearchBarView!
    
    @IBOutlet weak var searchBarBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        categoryBtn.applyCustomStyle(iconImg: UIImage(systemName: "line.3.horizontal"))
        categoryBtn.buttonTapAction = {
            print(#fileID, #function, #line, "- click category button")
        }
        
        alarmBtn.applyCustomStyle(iconImg: UIImage(systemName: "bell"))
        alarmBtn.buttonTapAction = {
            print(#fileID, #function, #line, "- click alarm button")
        }
        
        bookmarkBtn.applyCustomStyle(iconImg: UIImage(systemName: "bookmark"))
        bookmarkBtn.buttonTapAction = {
            print(#fileID, #function, #line, "- click bookmark button")
        }
        
        cartBtn.applyCustomStyle(iconImg: UIImage(systemName: "cart"))
        cartBtn.buttonTapAction = {
            print(#fileID, #function, #line, "- click cart button")
        }
        
        searchBar.applyCustomStyle(placeHolderText: "블랙 프라이데이 할인 중!!! 긴 텍스트 테스트!!!")
        searchBarBtn.addAction(UIAction(handler: { _ in
            print(#fileID, #function, #line, "- click search bar button")
//            var searchView = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "SearchView")
            self.present(SearchViewController(), animated: false)
        }), for: .touchUpInside)

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
