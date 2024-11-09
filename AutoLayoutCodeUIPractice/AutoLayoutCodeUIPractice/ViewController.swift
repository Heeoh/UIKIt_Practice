//
//  ViewController.swift
//  AutoLayoutCodeUIPractice
//
//  Created by Heeoh Son on 10/17/24.
//

import UIKit

class VStack: UIStackView {
    init(spacing: CGFloat = 10, alignment: UIStackView.Alignment = .center) {
        super.init(frame: .zero)
        self.setLayout(spacing, alignment)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.axis = .vertical
    }
    
    fileprivate func setLayout(_ spacing: CGFloat, _ alignment: UIStackView.Alignment) {
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

class HStack: UIStackView {
    init(spacing: CGFloat = 10, alignment: UIStackView.Alignment = .center) {
        super.init(frame: .zero)
        self.setLayout(spacing, alignment)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.axis = .horizontal
    }
    
    fileprivate func setLayout(_ spacing: CGFloat, _ alignment: UIStackView.Alignment) {
        self.axis = .horizontal
        self.spacing = spacing
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        let homeBanner = homeBanner
        
        self.view.addSubview(homeBanner)
        
        NSLayoutConstraint.activate([
            homeBanner.heightAnchor.constraint(equalToConstant: 150),
            homeBanner.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            homeBanner.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            homeBanner.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 100
            )
        ])
    }


}

extension ViewController {
    
    var homeBanner: UIView {
        let homeBanner = UIView()
        homeBanner.translatesAutoresizingMaskIntoConstraints = false
        homeBanner.backgroundColor = .systemMint.withAlphaComponent(0.15)
        homeBanner.layer.cornerRadius = 16
        
        // main horizontal stack - subtitle, title, image
        let mainHStack = bannerMainHStack
        
        // bottom horizontal stack - testerReview, leftTime
        let bottomHStack = bannerBottomHStack
        
        // main stack & bottom stack 위치 잡기
        homeBanner.addSubview(mainHStack)
        homeBanner.addSubview(bottomHStack)
        
        NSLayoutConstraint.activate([
            mainHStack.centerXAnchor.constraint(equalTo: homeBanner.centerXAnchor),
            mainHStack.leadingAnchor.constraint(
                equalTo: homeBanner.leadingAnchor,
                constant: 20
            ),
            mainHStack.topAnchor.constraint(
                equalTo: homeBanner.topAnchor,
                constant: 20
            ),
            
            bottomHStack.centerXAnchor.constraint(equalTo: homeBanner.centerXAnchor),
            bottomHStack.leadingAnchor.constraint(equalTo: mainHStack.leadingAnchor),
            bottomHStack.bottomAnchor.constraint(
                equalTo: homeBanner.bottomAnchor,
                constant: -20
            )
        ])
        
        return homeBanner
    }
    
    //  [ subtitle ]  | main  |
    //  [ title    ]  | image |
    fileprivate var bannerMainHStack: UIStackView {
       
        // subtitle, title로 구성된 vertical stack
        let titleVStack = VStack(spacing: 4, alignment: .leading)
        titleVStack.distribution = .fillProportionally
        
        let subTitle = UILabel()
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.text = "RE4DAY 올인원 프로바이오틱스"
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = .systemMint
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "안심원료로 믿고 먹는 \n100억 보장 패밀리 유산균"
        title.numberOfLines = 0
        title.font = .boldSystemFont(ofSize: 17)
        
        let mainImage = UIImageView(image: UIImage(systemName: "clipboard.fill"))
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            mainImage.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // title stack, main image로 구성된 horizontal stack
        let mainHStack = HStack(spacing: 4)
        
        mainHStack.addArrangedSubview(titleVStack)
        mainHStack.addArrangedSubview(mainImage)
        titleVStack.addArrangedSubview(subTitle)
        titleVStack.addArrangedSubview(title)
        
        return mainHStack
    }

    // [ ForMe 테스터 리뷰 ]   [ clock image 남은시간 ]
    fileprivate var bannerBottomHStack: UIStackView {
        let bottomHStack = HStack()
        bottomHStack.distribution = .equalCentering
        
        let testerReview = HStack(spacing: 4, alignment: .leading)
        let forMeText = UILabel()
        forMeText.text = "ForMe"
        forMeText.font = .systemFont(ofSize: 12, weight: .heavy)
        forMeText.textColor = .systemIndigo
        forMeText.translatesAutoresizingMaskIntoConstraints = false
        let reviewText = UILabel()
        reviewText.text = "테스터 리뷰"
        reviewText.font = .systemFont(ofSize: 12)
        reviewText.translatesAutoresizingMaskIntoConstraints = false
        
        testerReview.addArrangedSubview(forMeText)
        testerReview.addArrangedSubview(reviewText)
        
        
        let leftTime = HStack(spacing: 4)
        let leftTimeIcon = UIImageView(image: UIImage(systemName: "clock"))
        leftTimeIcon.tintColor = .black
        leftTimeIcon.translatesAutoresizingMaskIntoConstraints = false
        let leftTimeText = UILabel()
        leftTimeText.text = "03일 16시간 20분 남음"
        leftTimeText.font = .systemFont(ofSize: 12)
        leftTimeText.translatesAutoresizingMaskIntoConstraints = false

        leftTime.addArrangedSubview(leftTimeIcon)
        leftTime.addArrangedSubview(leftTimeText)
        
        bottomHStack.addArrangedSubview(testerReview)
        bottomHStack.addArrangedSubview(leftTime)
        
        return bottomHStack
    }
}

#if DEBUG

import SwiftUI

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

