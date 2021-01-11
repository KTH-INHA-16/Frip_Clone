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
    @IBOutlet weak var border: UIView!
    
    var hostIdx: Int = 0
    var save: Bool = false
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkButton.tintColor = UIColor.saveColor
        image.cornerRadius = image.bounds.width * 0.5
        
        hostNameLabel.font = UIFont.NotoSans(.bold, size: 15)
        hostCountLabel.font = UIFont.NotoSans(.regular, size: 12)
        hostCountLabel.textColor = .lightGray
        
    }
    
    @IBAction func hostSaveButton(_ sender: Any) {
        if save == true {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            bookmarkButton.tintColor = .lightGray
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookmarkButton.tintColor = UIColor.saveColor
        }
        save = !save
        CommonPostDataManager().hostLike(targetUrl: URL(string: Constant.HOST)!, idx: hostIdx, header: jwt)
    }
    
    
}
