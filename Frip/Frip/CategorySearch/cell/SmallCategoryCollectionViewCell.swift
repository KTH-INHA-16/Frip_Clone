//
//  SmallCategoryCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/06.
//

import UIKit

class SmallCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.NotoSans(.regular, size: 12)
        label.adjustsFontSizeToFitWidth = true
    }

}
