//
//  HostTextCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/09.
//

import UIKit

class HostTextCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hostDescriptionView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        hostDescriptionView.font = UIFont.NotoSans(.regular, size: 14)
    }

}
