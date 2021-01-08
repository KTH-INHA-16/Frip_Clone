//
//  MainCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var idx = 0
    var save = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.cornerRadius = 3
        
        place.font = UIFont.NotoSans(.regular, size: 9)
        shortDescription.font = UIFont.NotoSans(.medium, size: 10)
        shortDescription.adjustsFontSizeToFitWidth = true
        shortDescription.textColor = .lightGray
        
        title.font = UIFont.NotoSans(.regular, size: 13)
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .black
        
        price.font = UIFont.NotoSans(.bold, size: 12)
        price.textColor = .black
        
        place.font = UIFont.NotoSans(.regular, size: 10)

        point.font = UIFont.NotoSans(.regular, size: 10)
        point.textColor = .lightGray
    }
    
}
