//
//  ImageScrollView.swift
//  ScrollViewCodeUIPractice
//
//  Created by Heeoh Son on 11/8/24.
//

import Foundation
import UIKit

class ImageScrollView: UIView {
    let imageCount: Int = 4
    let images: [UIColor] = [.systemOrange, .systemMint, .systemPink, .systemCyan]
    var currentImageIdx: Int = 1 {
        didSet {
            self.updateImageIdxViewLabel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setLayout()
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var imageHStack : HStack = {
        let view = HStack(distribution: .fillEqually, alignment: .fill)
        
        images.forEach { color in
            let imageView = UIView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = color
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.53).isActive = true
            
            view.addArrangedSubview(imageView)
        }
        
        return view
    }()
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.isUserInteractionEnabled = true
        view.alwaysBounceHorizontal = true
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageHStack)
        
        NSLayoutConstraint.activate([
            imageHStack.leadingAnchor.constraint(equalTo: view.contentLayoutGuide.leadingAnchor),
            imageHStack.trailingAnchor.constraint(equalTo: view.contentLayoutGuide.trailingAnchor),
            imageHStack.topAnchor.constraint(equalTo: view.contentLayoutGuide.topAnchor),
            imageHStack.bottomAnchor.constraint(equalTo: view.contentLayoutGuide.bottomAnchor),
            imageHStack.heightAnchor.constraint(equalTo: view.frameLayoutGuide.heightAnchor, multiplier: 1)
        ])
        
        view.delegate = self
        
        return view
    }()
    
    private lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "\(currentImageIdx) / \(imageCount)"
        
        return label
    }()
    
    private lazy var imageIndexView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.layer.cornerRadius = 12
        
        view.addSubview(indexLabel)
        
        NSLayoutConstraint.activate([
            indexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indexLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
        
        return view
    }()

    private func setLayout() {
        
        // 스크롤 뷰에 이미지 인덱스를 추가
        self.addSubview(scrollView)
        self.addSubview(imageIndexView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imageIndexView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageIndexView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}

extension ImageScrollView: UIScrollViewDelegate {
    private func updateImageIdxViewLabel() {
        indexLabel.text = "\(currentImageIdx) / \(imageCount)"
//        print(#fileID, #function, #line, "- \(String(describing: indexLabel.text))")
    }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {

      let imageWidth = UIScreen.main.bounds.width

      let pageIndex = Int(scrollView.contentOffset.x / imageWidth)
      if pageIndex + 1 != currentImageIdx {
          self.currentImageIdx = pageIndex + 1
      }

//      print(#fileID, #function, #line, "- currentImageIdx: \(currentImageIdx)")
  }

}


#if DEBUG

import SwiftUI

class ImageScrollViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = ImageScrollView()
        
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
}

struct ImageScrollViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ImageScrollViewController()
    }
}

struct ImageScrollViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ImageScrollViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

#endif

