//
//  SaveFripViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class SaveFripViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var saveFrip: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoneCollectionViewCell")
        collectionView.reloadData()
    }

}

extension SaveFripViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if saveFrip.count != 0 {
            return saveFrip.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if saveFrip.count != 0 {
            return UICollectionViewCell()
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoneCollectionViewCell", for: indexPath) as? NoneCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.label1.text = "아직 저장한 프립이 없어요."
            cell.label2.text = "관심있는 프립을 저장해 보세요!"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if saveFrip.count != 0 {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    
}
