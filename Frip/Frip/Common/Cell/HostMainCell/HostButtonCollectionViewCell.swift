//
//  HostButtonCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/09.
//

import UIKit

class HostButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.NotoSans(.regular, size: 20)
    }

}
