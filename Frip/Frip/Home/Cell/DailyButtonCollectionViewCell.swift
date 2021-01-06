//
//  DailyButtonCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/06.
//

import UIKit

class DailyButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.borderColor = .lightGray
        button.borderWidth = 1
        button.cornerRadius = 5
    }

}
