//
//  FripCommentCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/07.
//

import UIKit

class FripCommentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var border: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starImg.tintColor = UIColor.saveColor
        
        rateLabel.font = UIFont.NotoSans(.medium, size: 16)
        commentLabel.font = UIFont.NotoSans(.medium, size: 16)
        descriptionLabel.font = UIFont.NotoSans(.medium, size: 19)
        
        commentLabel.textColor = UIColor.lightGray
    }

}
