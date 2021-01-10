//
//  OptionHeaderTableViewCell.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import UIKit

class OptionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.NotoSans(.regular, size: 18)
        label.sizeToFit()
        label.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
