//
//  Feed.swift
//  ScrollViewCodeUIPractice
//
//  Created by Heeoh Son on 11/2/24.
//

import Foundation
import UIKit

struct User : Codable {
    let userId: Int?
    var profileImage: String?
    var nickname: String?
    var description: String?
    var isFollowing: Bool?
}

struct TaggedItem: Codable {
}

struct Comment: Codable {
    var commentId: Int
    var writer: User?
    var content: String?
    var createdDate: String?
    var heartConut: Int?
}

//struct FeedImage: Codable {
//    var image: UIColor
//}

struct FeedData : Codable {
    var writer: User?
    var images: [String]
    var textContent: String?
    var itemsInImages: [TaggedItem]
    var heartCount: Int?
    var commentCount: Int?
    var shareCount: Int?
    var bookmarkCount: Int?
    var commentPreview: Comment?
    var createdDate: String?
}


// MARK: - Feed View
/// 피드 뷰
class FeedViewController: UIViewController {
    
    var feedData: FeedData?

    init(feedData: FeedData) {
        self.feedData = feedData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    
    private func setLayout() {
        let spacing: CGFloat = 12
        let sideMargin: CGFloat = 16
        
        let writerProfile = writerProfileRow
        let images = ImageScrollView()
        let itemsInImage = itemsInImage
        let reactionSummary = reactionSummary
        let textContent = textContent
        let commentDetail = commentDetail
        let createdDate = createdDate
        
        self.view.addSubview(writerProfile)
        self.view.addSubview(images)
        self.view.addSubview(itemsInImage)
        self.view.addSubview(reactionSummary)
        self.view.addSubview(textContent)
        self.view.addSubview(commentDetail)
        self.view.addSubview(createdDate)
        
        NSLayoutConstraint.activate([
            writerProfile.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            writerProfile.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            writerProfile.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            images.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            images.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            images.topAnchor.constraint(equalTo: writerProfile.bottomAnchor, constant: spacing),
            
            itemsInImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sideMargin),
            itemsInImage.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -sideMargin),
            itemsInImage.topAnchor.constraint(equalTo: images.bottomAnchor, constant: spacing),
            
            reactionSummary.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sideMargin),
            reactionSummary.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -sideMargin),
            reactionSummary.topAnchor.constraint(equalTo: itemsInImage.bottomAnchor, constant: spacing),
            
            textContent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sideMargin),
            textContent.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -sideMargin),
            textContent.topAnchor.constraint(equalTo: reactionSummary.bottomAnchor, constant: spacing),
            
            commentDetail.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sideMargin),
            commentDetail.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -sideMargin),
            commentDetail.topAnchor.constraint(equalTo: textContent.bottomAnchor, constant: spacing),
            
            createdDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sideMargin),
            createdDate.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -sideMargin),
            createdDate.topAnchor.constraint(equalTo: commentDetail.bottomAnchor, constant: 4),
            createdDate.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor)
        ])
    }
}
    
// MARK: - writer profile row
extension FeedViewController {
    
    /// 피드 작성자 프로필 (프로필이미지, 닉네임, 한줄소개)
    fileprivate var writerProfileRow: UIView {
        let profileButton: UIView = userProfileView
        
        let ellipsisButton = IconButton(icon: UIImage(systemName: "ellipsis"),
                                        bgColor: .systemYellow, tintColor: .black)
        ellipsisButton.setAction(target: self, action: #selector(ellipsisBtnTapped))
        
        let writerProfileRow: HStack = {
            let view = HStack(distribution: .fill, alignment: .center, spacing: 8)
            view.setPadding(horizontal: 12)
            view.addArrangedSubview(profileButton)
            view.addArrangedSubview(ellipsisButton)
            
            return view
            
        }()
        
        return writerProfileRow
    }
    
//        private var followButton: UIButton {
//            let isFollowing: Bool = false
//    let followButton: UIButton = {
//                let button = UIButton(configuration: .plain())
//                button.translatesAutoresizingMaskIntoConstraints = false
//    
//                button.setTitle("팔로우", for: .normal)
//                button.setTitleColor(UIColor.systemBlue, for: .normal)
//    
//                return button
//            }()
//        }
    
    /// 피드 작성자 프로필 부분
    /// - 프로필이미지, 닉네임, 소개, 팔로잉 여부
    /// - 클릭 시 유저 페이지로 이동
    private var userProfileView: UIView {
//        let userProfileImg: String = feedData?.writer?.profileImage ?? ""
        let userName: String = feedData?.writer?.nickname ?? ""
        let userDescription: String = feedData?.writer?.description ?? ""
        let isFollowing: Bool = feedData?.writer?.isFollowing ?? false
        
        // 프로필 이미지
        let profileImage: UIView = {
            let view = RoundedRectangle(cornerRadius: 25)
            view.layer.backgroundColor = UIColor.systemYellow.cgColor
            view.setSize(width: 50, height: 50)
            
            return view
        }()
        
        // 닉네임 & 소개
        let infoVStack: VStack = {
            
            // 닉네임
            let name : UIView = {
                let nameLabel = UILabel()
                nameLabel.translatesAutoresizingMaskIntoConstraints = false
                nameLabel.text = userName
                nameLabel.font = .boldSystemFont(ofSize: 14)
                nameLabel.numberOfLines = 1
                
                // 팔로잉 한 유저인 경우 닉네임 뒤에 팔로잉 라벨 붙음
                if !isFollowing {
                    return nameLabel
                } else {
                    // 팔로잉 라벨
                    let followingLabel = UILabel()
                    followingLabel.translatesAutoresizingMaskIntoConstraints = false
                    followingLabel.text = " • 팔로잉"
                    followingLabel.font = .systemFont(ofSize: 12)
                    followingLabel.numberOfLines = 1
                    
                    // 닉네임 + 팔로잉라벨 뷰
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    
                    view.addSubview(nameLabel)
                    view.addSubview(followingLabel)
                    
                    NSLayoutConstraint.activate([
                        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        nameLabel.topAnchor.constraint(equalTo: view.topAnchor),
                        nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        followingLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
                        followingLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
                        followingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    ])
                    
                    return view
                }
                
            }()
            
            // 소개
            let description: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = userDescription
                label.font = .systemFont(ofSize: 14)
                label.textColor = .darkGray
                label.numberOfLines = 1
                return label
            }()
            
            let view = VStack(distribution: .fill, alignment: .leading, spacing: 6)
            view.addArrangedSubview(name)
            view.addArrangedSubview(description)
            
            return view
        }()
        
        
        let profileView : HStack = {
            let stackView = HStack(distribution: .fill, alignment: .center, spacing: 8)
            stackView.addArrangedSubview(profileImage)
            stackView.addArrangedSubview(infoVStack)
            
            return stackView
        }()
        
        // 프로필 부분 클릭 시 유저 페이지 이동을 위한 버튼
        let button : UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        button.addTarget(self, action: #selector(userProfileBtnTapped), for: .touchUpInside)
        
        // view + button
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
}

// MARK: - items in images
extension FeedViewController {
    
    /// 이미지에 태그된 상품 리스트 (4개까지만)
    private var itemsInImage: UIView {
        let stack: HStack = {
            let view = HStack(distribution: .fillEqually, alignment: .fill, spacing: 4)
            
            let items : [UIColor] = [.systemRed, .systemCyan, .systemMint, .systemPink]
            items.forEach{ color in
                let itemView = RoundedRectangle(cornerRadius: 4)
                itemView.backgroundColor = color
                itemView.widthAnchor.constraint(equalToConstant: 60).isActive = true
                itemView.heightAnchor.constraint(equalTo: itemView.widthAnchor, multiplier: 1).isActive = true
                
                view.addArrangedSubview(itemView)
            }
            
            return view
        }()
        
        return stack
    }
    
}


// MARK: - reaction summary
extension FeedViewController {
    /// 하트, 댓글, 공유 개수
    private var reactionSummary: UIView {
        let emptyView : UIView = {
           let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
//            view.heightAnchor.constraint(equalToConstant: 10).isActive = true
            
            return view
        }()
        
        let heart = generateReactionButton(image: "heart", count: feedData?.heartCount ?? 0)
        let comment = generateReactionButton(image: "bubble", count: feedData?.commentCount ?? 0)
        let share = generateReactionButton(image: "square.and.arrow.up", count: feedData?.shareCount ?? 0)
        let bookmark = generateReactionButton(image: "bookmark", count: feedData?.bookmarkCount ?? 0)
        
        let stack = HStack(distribution: .fill, alignment: .fill, spacing: 8)
        stack.addArrangedSubview(heart)
        stack.addArrangedSubview(comment)
        stack.addArrangedSubview(share)
        stack.addArrangedSubview(emptyView)
        stack.addArrangedSubview(bookmark)
        
        return stack
    }
    
    /// reaction summary 뷰 생성
    /// - Parameters:
    ///   - image: reaction 아이콘 이미지
    ///   - count: reaction 개수
    /// - Returns: [ iconImage  count ] ui view 리턴
    private func generateReactionButton(image: String, count: Int) -> UIView {
        let imageView : UIImageView = {
            let view = UIImageView(image: UIImage(systemName: image))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = .black
            view.widthAnchor.constraint(equalToConstant: 24).isActive = true
            view.heightAnchor.constraint(equalToConstant: 24).isActive = true
            view.contentMode = .scaleAspectFit
            
            return view
        }()
        
        let countLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = count > 0 ? "\(count)" : ""
            label.font = .systemFont(ofSize: 12)
            label.textColor = .black
            
            return label
        }()
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        view.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            countLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            countLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        return view
    }
}
    
// MARK: - text content
extension FeedViewController {
    /// 피드 텍스트
    private var textContent: UIView {
        let content = feedData?.textContent ?? ""
        
        let textContent: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12)
            label.numberOfLines = 2
            label.text = content
            
            return label
        }()
        
        return textContent
    }
}
    

// MARK: - comment detail
extension FeedViewController {
    
    /// 댓글 전체보기 버튼, 댓글 1개 미리보기
    private var commentDetail: UIView {
        let count = feedData?.commentCount ?? 0
        let commentPreview = feedData?.commentPreview
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // 댓글이 없을 경우, 댓글 전체보기 버튼과 미리보기가 안보임
        if count == 0 {
            return view
        }
        
        // 미리보기 댓글에 오류가 있을 경우
        guard let commentPreview = commentPreview else {
            return view
        }
        
        // 댓글 전체보기 버튼 뷰
        let moreCommentButton: UIView = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12)
            label.textColor = .darkGray
            label.numberOfLines = 1
            label.text = "댓글 \(count)개 모두 보기"
            
            return label
        }()
        
        // 미리보기 댓글 (최대 1개)
        let aComment: UIView = {
            let content = UILabel()
            content.translatesAutoresizingMaskIntoConstraints = false
            content.font = .systemFont(ofSize: 12)
            content.numberOfLines = 1
            content.text = commentPreview.content
            
            return content
        }()
        
        
        // 댓글 페이지 이동을 위한 버튼
        let button: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        button.addTarget(self, action: #selector(commentDetailBtnTapped), for: .touchUpInside)
        
        view.addSubview(moreCommentButton)
        view.addSubview(aComment)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            moreCommentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moreCommentButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 0),
            moreCommentButton.topAnchor.constraint(equalTo: view.topAnchor),
            
            aComment.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aComment.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 0),
            aComment.topAnchor.constraint(equalTo: moreCommentButton.bottomAnchor, constant: 2),
            aComment.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.backgroundColor = .yellow
        return view
        
    }
}


// MARK: - created date
extension FeedViewController {
    /// 피드 작성일
    private var createdDate: UIView {
        let dateText: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 11)
            label.textColor = .darkGray
            label.numberOfLines = 1
            label.text = "10.19"
            
            return label
        }()
        
        return dateText
    }
}


// MARK: - action
extension FeedViewController {
    
    /// 피드 ellipsis 버튼 클릭 시, 신고하기 액션시트 나타남
    @objc private func ellipsisBtnTapped() {
        
        let actionSheet = UIAlertController()
        let report = UIAlertAction(title: "신고하기", style: .destructive) { action in
            print("action sheet 피드 신고하기 클릭")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("action sheet 취소 클릭")
        }
        
        [report, cancel].forEach {
            actionSheet.addAction($0)
        }
    
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    /// 유저 프로필 클릭 시, 유저 페이지로 이동
    @objc private func userProfileBtnTapped() {
        print("\(feedData?.writer?.nickname ?? "???")의 유저 페이지로 이동")
    }
    
    /// 댓글 전체보기 또는 미리보기 댓글 클릭 시, 댓글 페이지로 이동
    @objc private func commentDetailBtnTapped() {
        print("\(feedData?.commentCount ?? 0)개의 댓글 전체보기 페이지로 이동")
    }
}


#if DEBUG

import SwiftUI

struct FeedViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        FeedViewController(feedData: FeedData(writer: User(userId: 1, profileImage: "", nickname: "sund_home", description: "hello hello hello hello", isFollowing: true),
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

struct FeedViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FeedViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

#endif

