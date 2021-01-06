//
//  DailyBigCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/06.
//

import UIKit

class DailyBigCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var border: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        border.backgroundColor = .lightGray
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.NotoSans(.medium, size: 16)
    }

}
