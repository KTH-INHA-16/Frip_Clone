//
//  FripIntroCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import UIKit

class FripIntroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionTextView.font = UIFont.NotoSans(.regular, size: 15)
        
        label.font = UIFont.NotoSans(.bold, size: 17)
    }

}
