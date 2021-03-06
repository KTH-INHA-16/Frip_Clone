//
//  DailyBigCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/06.
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
