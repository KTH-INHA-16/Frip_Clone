//
//  FripCommonCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import UIKit

class FripCommonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var border: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLable.font = UIFont.NotoSans(.bold, size: 17)
        textView.font = UIFont.NotoSans(.regular, size: 15)
        
    }

}
