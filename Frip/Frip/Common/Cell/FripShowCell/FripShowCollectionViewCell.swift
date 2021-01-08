//
//  FripShowCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import UIKit

class FripShowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.NotoSans(.medium, size: 25)
        
        priceLabel.font = UIFont.NotoSans(.bold, size: 20)
        
        dateLabel.text = "유효기간: 구매일로부터 30일"
        dateLabel.font = UIFont.NotoSans(.regular, size: 15)
        dateLabel.textColor = .lightGray
    }

}
