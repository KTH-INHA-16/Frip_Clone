//
//  CommentShowCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import UIKit

class CommentShowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userRateLabel: UILabel!
    @IBOutlet weak var userDateLabel: UILabel!
    @IBOutlet weak var userCommentView: UITextView!
    @IBOutlet weak var fripTitleLabel: UILabel!
    @IBOutlet weak var fripOptionLabel: UILabel!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var hostDateLabel: UILabel!
    @IBOutlet weak var hostCommentView: UITextView!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var view: UIView!
    
    var isSave = false
    var likeCount: Int = 0
    var fripIdx: Int = 0
    var reviewIdx: Int = 0
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.tintColor = UIColor.saveColor
        
        userImage.cornerRadius = userImage.frame.height * 0.5
        
        userNameLabel.font = UIFont.NotoSans(.bold, size: 13)
        userRateLabel.font = UIFont.NotoSans(.regular, size: 13)
        userRateLabel.textColor = .lightGray
        userDateLabel.font = UIFont.NotoSans(.regular, size: 13)
        userDateLabel.textColor = .lightGray
        
        userCommentView.font = UIFont.NotoSans(.regular, size: 13)
        
        fripTitleLabel.font = UIFont.NotoSans(.regular, size: 13)
        fripTitleLabel.textColor = .lightGray
        fripOptionLabel.font = UIFont.NotoSans(.regular, size: 13)
        fripOptionLabel.textColor = .lightGray
        
        commentImage.cornerRadius = commentImage.frame.height / 8
        
        hostImage.cornerRadius = hostImage.frame.height * 0.5
        hostNameLabel.font = UIFont.NotoSans(.bold, size: 13)
        hostDateLabel.font = UIFont.NotoSans(.regular, size: 13)
        hostDateLabel.textColor = .lightGray
        
        hostCommentView.font = UIFont.NotoSans(.regular, size: 13)
        
        view.cornerRadius = view.bounds.height / 8
    }
    @IBAction func goodButtonTapDown(_ sender: Any) {
        CommonPostDataManager().commentLikePost(targetUrl: URL(string: Constant.ALL_FRIP)!, fripIdx: fripIdx, reviewIdx: reviewIdx, header: jwt)
        if isSave == false{
            likeCount += 1
            goodButton.setTitle("도움이 됐어요\(likeCount)", for: .normal)
            goodButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            goodButton.tintColor = .systemBlue
            goodButton.setTitleColor(.systemBlue, for: .normal)
        } else {
            likeCount -= 1
            goodButton.setTitle("도움이 됐어요\(likeCount)", for: .normal)
            goodButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            goodButton.tintColor = .lightGray
            goodButton.setTitleColor(.lightGray, for: .normal)
        }
        isSave = !isSave
    }
    
}
