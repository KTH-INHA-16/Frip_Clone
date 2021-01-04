import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    var bigCategory: String = ""
    var littleCategory: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()

        label.font = UIFont.NotoSans(.regular, size: 17)
        view.cornerRadius = 5
    }

}
