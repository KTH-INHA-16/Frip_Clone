//
//  BestButtonCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/06.
//

import UIKit

class BestButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = 5
        button.adjustsFontSizeToFitWidth = true
    }

}
