//
//  SearchViewController.swift
//  OHouseHomePractice
//
//  Created by Heeoh Son on 11/29/24.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    
//    @IBOutlet weak var backBtn: IconButton!
//    
//    @IBOutlet weak var searchBar: SearchBarView!
//    @IBOutlet weak var searchInput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#fileID, #function, #line, "")
        
//        backBtn.applyCustomStyle(iconImg: UIImage(systemName: "arrow.left"))
//        backBtn.buttonTapAction = {
//            print(#fileID, #function, #line, "back button clicked")
//        }
        

    }
}

#if DEBUG

import SwiftUI

extension SearchViewController {
    /// iOS 17 이상일 때, previewProvider를 사용하기 위해 VC instance를 만드는 팩토리 메소드
    class func makeInstance() -> SearchViewController {
        let storyboard = UIStoryboard(name: "SearchView", bundle: nil)
        return storyboard.instantiateInitialViewController() as! SearchViewController
    }
}

@available(iOS 17, *)
#Preview {
    return SearchViewController.makeInstance()
}

struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SearchViewController()
    }
}

struct SearchViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        SearchViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

#endif
