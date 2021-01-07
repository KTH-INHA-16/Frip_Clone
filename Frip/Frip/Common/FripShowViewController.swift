//
//  FripShowViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import UIKit

class FripShowViewController: BaseViewController {
    
    let identifier = ["FripImageCollectionViewCell","FripShowCollectionViewCell","HostCollectionViewCell","FripCommentCollectionViewCell"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        registerCell(collectionView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func registerCell(_ view: UICollectionView!) {
        for idn in identifier {
            view.register(UINib(nibName: idn, bundle: nil), forCellWithReuseIdentifier: idn)
        }
    }

}

extension FripShowViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
        switch indexPath.section {
        case 0:
            let cell = allCell as! FripImageCollectionViewCell
            return cell
        case 1:
            let cell = allCell as! FripShowCollectionViewCell
            return cell
        case 2:
            let cell = allCell as! HostCollectionViewCell
            return cell
        case 3:
            let cell = allCell as! FripCommentCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 400)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 230)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 150)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 300)
        default:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
}
