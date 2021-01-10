//
//  OptionClickTableViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import UIKit

class OptionClickTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var option = 0
    var cnt = 1
    var price = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        optionLabel.adjustsFontSizeToFitWidth = true
        optionLabel.font = UIFont.NotoSans(.regular, size: 15)
        
        priceLabel.font = UIFont.NotoSans(.bold, size: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
