//
//  BtnCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class BtnCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    var idx = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.cornerRadius = button.frame.width * 0.5
        button.borderWidth = 1
        button.borderColor = .systemGray
        button.imageView?.frame.size = CGSize(width: 38, height: 38)
        button.layoutMargins = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.NotoSans(.medium, size: 12)
        label.textColor = .lightGray
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        print(idx)
        button.imageView?.image = UIImage(named: "ButtonImage\(idx)")
    }
    
}
