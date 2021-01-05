//
//  NoneCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class NoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.tintColor = .lightGray
        
        label1.adjustsFontSizeToFitWidth = true
        label2.adjustsFontSizeToFitWidth = true
        
        label1.font = UIFont.NotoSans(.bold, size:  19)
        label1.textColor = .lightGray

        
        label2.font = UIFont.NotoSans(.regular, size: 15)
        label2.textColor = .lightGray
    }

}
