//
//  CategorySearchViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class CategorySearchViewController: BaseViewController {

    
    var bigCategory: String = ""
    var smallCategory: String = ""
    
    init(_ bigCategory:String,_ smallCategory: String) {
        self.bigCategory = bigCategory
        self.smallCategory = smallCategory
        super.init(nibName: "CategorySearchViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
