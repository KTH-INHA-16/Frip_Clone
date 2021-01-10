//
//  NothingCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import UIKit

class NothingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.text = "검색 결과가 존재하지 않습니다"
        label.font = UIFont.NotoSans(.bold, size: 20)
        label.adjustsFontSizeToFitWidth = true
    }

}
