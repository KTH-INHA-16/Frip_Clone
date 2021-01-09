//
//  HostButtonCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/09.
//

import UIKit

class HostButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.NotoSans(.regular, size: 20)
    }

}
