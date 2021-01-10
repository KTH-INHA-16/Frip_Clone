//
//  OptionTableViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionTitleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var count = 0
    var price: String = ""
    var option: FripOption = FripOption(fripOptionIdx: 0, fripOption: "", price: "", limitcount: "", isEnd: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionTitleLabel.adjustsFontSizeToFitWidth = true
        optionTitleLabel.font = UIFont.NotoSans(.regular, size: 15)
        
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.font = UIFont.NotoSans(.regular, size: 14)
        
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.font = UIFont.NotoSans(.bold, size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
