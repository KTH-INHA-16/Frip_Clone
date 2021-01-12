//
//  FeedUserViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/12.
//

import UIKit

class FeedUserViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "작성 가능한 후기"
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
