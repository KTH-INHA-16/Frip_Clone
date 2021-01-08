//
//  CommentHeaderCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import UIKit

class CommentHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rateAverageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.font = UIFont.NotoSans(.regular, size: 20)
        label1.font = UIFont.NotoSans(.bold, size: 20)
        
        label2.font = UIFont.NotoSans(.regular, size: 15)
        
        image.tintColor = UIColor.saveColor
        
        rateAverageLabel.font = UIFont.NotoSans(.regular, size: 16)
        
    }

}
