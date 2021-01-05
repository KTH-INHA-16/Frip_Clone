//
//  HostCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class HostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var hostCountLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkButton.tintColor = UIColor.saveColor
        image.cornerRadius = image.frame.width * 0.5
        
        hostNameLabel.font = UIFont.NotoSans(.bold, size: 15)
        hostCountLabel.font = UIFont.NotoSans(.regular, size: 12)
        hostCountLabel.textColor = .lightGray
        
    }
    
}
