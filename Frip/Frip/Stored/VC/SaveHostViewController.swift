//
//  SaveHostViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class SaveHostViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var saveHost: [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoneCollectionViewCell")
        collectionView.register(UINib(nibName: "HostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HostCollectionViewCell")
        collectionView.reloadData()
        print("saveHost")
    }

}

extension SaveHostViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if saveHost.count != 0 {
            return saveHost.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if saveHost.count != 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostCollectionViewCell", for: indexPath) as? HostCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bookmarkButton.addTarget(self, action: #selector(hostTap), for: .touchDown)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoneCollectionViewCell", for: indexPath) as? NoneCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.label1.text = "아직 저장한 호스트가 없어요."
            cell.label2.text = "관심있는 호스트를 저장해 보세요!"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if saveHost.count != 0 {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: 50)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
 
    @objc func hostTap() {
        
    }
}
