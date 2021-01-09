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

}
