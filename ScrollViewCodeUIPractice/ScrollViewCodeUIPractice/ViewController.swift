//
//  ViewController.swift
//  ScrollViewCodeUIPractice
//
//  Created by Heeoh Son on 10/30/24.
//

import UIKit


class ViewController: UIViewController {

    private var feedDataArray: [FeedData] = []
    private let mainContentVStack = VStack(distribution: .fill, alignment: .fill, spacing: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.feedDataArray = []
        self.makeDummyFeedData(count: 3)
        self.setLayout()
    }
    
    private func setLayout() {
        let slideToggle = slideToggle
        
        
            let shortcutButtons = shortcutButtons
            shortcutButtons.layer.backgroundColor = UIColor.systemYellow.cgColor

        mainContentVStack.addArrangedSubview(shortcutButtons)
            self.addFeedVC()
            
      
        
        let mainContentScrollView: UIScrollView = {
            let view = UIScrollView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = true
            view.alwaysBounceVertical = true
            view.alwaysBounceHorizontal = false
            
            return view
        }()
        mainContentScrollView.refreshControl = UIRefreshControl()
        mainContentScrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl(_:)), for: .valueChanged)
    
        
        // main content scroll view layout
        mainContentScrollView.addSubview(mainContentVStack)
        
        NSLayoutConstraint.activate([
            mainContentVStack.leadingAnchor.constraint(equalTo: mainContentScrollView.contentLayoutGuide.leadingAnchor),
            mainContentVStack.trailingAnchor.constraint(equalTo: mainContentScrollView.contentLayoutGuide.trailingAnchor),
            mainContentVStack.topAnchor.constraint(equalTo: mainContentScrollView.contentLayoutGuide.topAnchor),
            mainContentVStack.bottomAnchor.constraint(equalTo: mainContentScrollView.contentLayoutGuide.bottomAnchor),
            mainContentVStack.widthAnchor.constraint(equalTo: mainContentScrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
        ])
        
        // self.view layout
        self.view.addSubview(slideToggle)
        self.view.addSubview(mainContentScrollView)
        
        NSLayoutConstraint.activate([
            slideToggle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            slideToggle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            slideToggle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            mainContentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContentScrollView.topAnchor.constraint(equalTo: slideToggle.bottomAnchor, constant: 2),
            mainContentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
    }
}

// MARK: - slideToggle
extension ViewController {
    var slideToggle: UIView {
        let toggle = UIView()
        toggle.translatesAutoresizingMaskIntoConstraints = false

        // labels
        let labelHStack = HStack(distribution: .fillEqually, alignment: .fill)
        let label1 = generateToggleButton("홈")
        let label2 = generateToggleButton("발견")
        
        labelHStack.addArrangedSubview(label1)
        labelHStack.addArrangedSubview(label2)
        
        // indicator
        let indicator = UIView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.layer.backgroundColor = UIColor.black.cgColor

        
        // layout
        toggle.addSubview(labelHStack)
        toggle.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            labelHStack.topAnchor.constraint(equalTo: toggle.topAnchor, constant: 0),
            labelHStack.leadingAnchor.constraint(equalTo: toggle.leadingAnchor, constant: 0),
            labelHStack.trailingAnchor.constraint(equalTo: toggle.trailingAnchor, constant: 0),
            
            indicator.heightAnchor.constraint(equalToConstant: 3),
            indicator.widthAnchor.constraint(equalTo: labelHStack.widthAnchor, multiplier: 0.5),
            indicator.topAnchor.constraint(equalTo: labelHStack.bottomAnchor, constant: 0),
            indicator.bottomAnchor.constraint(equalTo: toggle.bottomAnchor),
            indicator.leadingAnchor.constraint(equalTo: labelHStack.leadingAnchor, constant: 0)
        ])

        return toggle
    }
    
    private func generateToggleButton(_ text: String) -> UIView {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.darkGray, for: .normal)
        button.contentHorizontalAlignment = .center
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return button
    }
}


// MARK: - shortcut buttons
extension ViewController {
    var shortcutButtons: UIView {
        let buttonHStack : HStack = {
            let view = HStack(distribution: .fillEqually, alignment: .fill, spacing: 4)
            view.setPadding(vertical: 20, horizontal: 16)
            
            let labels: [String] = ["바이너리위크", "오늘의딜", "셀릭트샵", "집들이", "행운출첵", "가드닝게임", "챌린지참여", "취향의발견"]
            
            labels.forEach {
                view.addArrangedSubview(generateShortcutButton(text: $0))
            }
            
            return view
        }()
        
        let scrollView : UIScrollView = {
            let view = UIScrollView()
            view.isUserInteractionEnabled = true
            view.alwaysBounceHorizontal = true
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(buttonHStack)
            
            return view
        }()
        
        NSLayoutConstraint.activate([
            buttonHStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            buttonHStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            buttonHStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            buttonHStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            buttonHStack.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1)
        ])
   
        return scrollView
    }
    
    private func generateShortcutButton(text: String) -> UIView {
        let iconImage : UIView = {
            let view = RoundedRectangle(cornerRadius: 16)
            view.widthAnchor.constraint(equalToConstant: 50).isActive = true
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
            view.layer.backgroundColor = UIColor.systemGray4.cgColor
            return view
        }()
        
        let label : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        let shortcutBtn : UIView = {
            let view = VStack(distribution: .fill, alignment: .center, spacing: 8)
            view.addArrangedSubview(iconImage)
            view.addArrangedSubview(label)
            
            return view
        }()
        
        return shortcutBtn
    }
}


// MARK: - feed
extension ViewController {
    
    /// make dummy feed data
    /// - Parameter count: the number of created feed data
    private func makeDummyFeedData(count: Int) {
        Array(0...count).forEach { idx in
            feedDataArray.append(FeedData(writer: User(userId: idx, profileImage: "", nickname: "user \(idx)", description: "hello hello hello hello", isFollowing: true),
                     images: [],
                     textContent: "허전한 침실 벽을 감성으로 채워주는 밤테리어 dsfalklailadksfh alksfhasldkfj halkdjfhasdlkfhasl af hldakf slkdhflsadk dlkj dksl dlskf kld fdlkaf ladhfaiwuehfksd fkl flkd kl",
                     itemsInImages: [],
                     heartCount: 2000,
                     commentCount: 100,
                     shareCount: 2000,
                     bookmarkCount: 17,
                     commentPreview: Comment(commentId: 1, writer: User(userId: 2, profileImage: "", nickname: "whoAmI", description: "", isFollowing: false), content: "wowowowow", createdDate: "2024-10-31", heartConut: 0),
                     createdDate: "2024-10-20"))
        }
    }
    
    /// add child feed view controllers using feed data array
    private func addFeedVC() {
        for feedData in feedDataArray {
            let feedVC = FeedViewController(feedData: feedData)
            addChild(feedVC)
            self.mainContentVStack.addArrangedSubview(feedVC.view)
            feedVC.didMove(toParent: self)
        }
    }
    
    /// remove all child feed view controller
    private func removeFeedVC() {
        self.mainContentVStack.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}


// MARK: - refresh
extension ViewController {
    @objc func handleRefreshControl(_ refreshControl: UIRefreshControl?) {
         print("refresh")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.removeFeedVC()
            refreshControl?.endRefreshing()
            self.viewDidLoad()
        })
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

