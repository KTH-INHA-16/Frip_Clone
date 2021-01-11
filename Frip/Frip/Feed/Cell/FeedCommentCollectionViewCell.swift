//
//  FeedCommentCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import UIKit

class FeedCommentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.cornerRadius = image.bounds.width * 0.5
        
        name.font = UIFont.NotoSans(.regular, size: 12)
        comment.font = UIFont.NotoSans(.regular, size: 14)
        time.font = UIFont.NotoSans(.regular, size: 12)
        
        comment.backgroundColor = .systemGray6
        
    }

}
