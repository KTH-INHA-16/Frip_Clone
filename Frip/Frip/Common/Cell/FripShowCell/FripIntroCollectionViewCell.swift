//
//  FripIntroCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/08.
//

import UIKit

class FripIntroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var border: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionTextView.font = UIFont.NotoSans(.regular, size: 15)
        
        label.font = UIFont.NotoSans(.bold, size: 17)
        border.backgroundColor = .lightGray
    }

}
