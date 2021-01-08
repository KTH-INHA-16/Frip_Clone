//
//  FripCommentViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import UIKit

class FripCommentViewController: BaseViewController {
    
    var fripIdx:Int = 0
    var commentCount: String = ""
    var rate: String = ""
    var comments: [Any] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    init(fripIdx: Int) {
        self.fripIdx = fripIdx
        super.init(nibName: "FripCommentViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("eariler \(fripIdx)")
        self.navigationController?.navigationItem.title = "후기"
        self.tabBarController?.tabBar.isHidden = true
        
        collectionView.register(UINib(nibName: "CommentHeader", bundle: nil), forCellWithReuseIdentifier: "CommentHeader")
        collectionView.register(UINib(nibName: "CommentShow", bundle: nil), forCellWithReuseIdentifier: "CommentShow")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.register(UINib(nibName: "CommentHeader", bundle: nil), forCellWithReuseIdentifier: "CommentHeader")
        collectionView.register(UINib(nibName: "CommentShow", bundle: nil), forCellWithReuseIdentifier: "CommentShow")
        self.tabBarController?.tabBar.isHidden = true
        collectionView.backgroundColor = .black
        collectionView.alpha = 0.05
        indicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }


}

extension FripCommentViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentHeader", for: indexPath) as! CommentHeaderCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentShow", for: indexPath) as! CommentShowCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 195)
        } else {
            return CGSize(width: collectionView.frame.width, height: 510)
        }
    }
    
}
