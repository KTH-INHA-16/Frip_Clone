//
//  IndicatorCollectionViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import UIKit

class IndicatorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
    }

}
