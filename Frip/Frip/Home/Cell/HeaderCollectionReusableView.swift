//
//  HeaderCollectionReusableView.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    var kind: String = ""
    var label: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.NotoSans(.bold, size: 18)
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        let attributes : [NSAttributedString.Key: Any] = [ .font : UIFont.NotoSans(.regular, size: 12), .foregroundColor : UIColor.systemGray]
        button.setAttributedTitle(NSAttributedString(string: "전체보기", attributes: attributes), for: .normal)
        return button
    }()

    
    func configure(_ text: String) {
        label.text = text
        addSubview(label)
    }
    
    func buttonConfigure(_ kind: String) {
        self.kind = kind
        button.addTarget(self, action: #selector(viewAll), for: .touchDown)
        self.addSubview(button)
    }
    
    @objc func viewAll() {
        print("\(kind)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 20, y: 5, width: frame.width * 0.6, height: 30)
        button.frame = CGRect(x: frame.width * 0.85,y: 5,width: frame.width * 0.15,height: 25)
    }
}
