//
//  FeedViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/03.
//

import UIKit

class FeedViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "프립 피드"
        
        
    }

}
