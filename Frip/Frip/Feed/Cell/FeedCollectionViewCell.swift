//
//  FeedCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userDate: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var fripTitle: UIButton!
    @IBOutlet weak var commentView: UITextView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    var fripIdx: Int = 0
    var feedIdx:Int = 0
    var feedLikeCnt: Int = 0
    var feedCommentCnt: Int = 0
    var userIdx:Int = 0
    var isLike: Bool = false
    var likeCount: Int = 0
    var messageCount: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.cornerRadius = userImage.bounds.width * 0.5
        touchView.cornerRadius = touchView.bounds.width / 22
        touchView.borderWidth = 1
        touchView.borderColor = .lightGray
        feedImage.cornerRadius = feedImage.bounds.width / 8
        
        userDate.font = UIFont.NotoSans(.regular, size: 13)
        userName.font = UIFont.NotoSans(.regular, size: 13)
        commentView.font = UIFont.NotoSans(.regular, size: 13)
        
        userDate.textColor = .lightGray
        
    }
    
    @IBAction func LikeButtonTouchDown(_ sender: Any) {
        if isLike == true {
            feedLikeCnt -= 1
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .black
        } else {
            feedLikeCnt += 1
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        }
        likeButton.setTitle("\(feedLikeCnt)", for: .normal)
        isLike = !isLike
        FeedPostDataManager().postFeedLike(url: Constant.FEED_LIKE, reviewIdx: feedIdx)
    }
    

}
