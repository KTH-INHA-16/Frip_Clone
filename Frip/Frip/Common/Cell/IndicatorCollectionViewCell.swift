//
//  IndicatorCollectionViewCell.swift
//  Frip
//
//  Created by κΉνν on 2021/01/07.
//

import UIKit

class IndicatorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
    }

}
