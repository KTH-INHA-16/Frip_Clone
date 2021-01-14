//
//  SaveFripViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class SaveFripViewController: BaseViewController {

    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    var frips: [SaveFrip] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoneCollectionViewCell")
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        
        DispatchQueue.global(qos: .userInitiated).sync {
            StoredGetManager().getUserFrips(targetURL: Constant.FRIP_LIKE, header: jwt, vc: self)
        }
    }
    
    func getFrips(_ result:[SaveFrip]) {
        for r in result {
            frips.append(r)
        }
        return collectionView.reloadData()
    }
    
    func getDetail(_ result: FripDetailInfo,_ index: Int) {
        let vc = FripShowViewController(index, result)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension SaveFripViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if frips.count != 0 {
            return frips.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if frips.count != 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            if frips.count != 0 {
                let frip = frips[indexPath.row]
                let url = URL(string: frip.fripPhotoUrl)
                cell.image.kf.setImage(with: url)
                cell.idx = frip.fripIdx
                cell.save = true
                cell.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                cell.saveButton.tintColor = UIColor.saveColor
                cell.saveButton.tag = indexPath.row
                cell.saveButton.addTarget(self, action: #selector(buttonTap(sender:)), for: .touchDown)
                cell.price.text = frip.price
                cell.place.text = frip.place
                cell.point.text = frip.rate
                cell.title.text = frip.fripTitle
                cell.shortDescription.text = frip.fripHeader
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoneCollectionViewCell", for: indexPath) as? NoneCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.label1.text = "아직 저장한 프립이 없어요."
            cell.label2.text = "관심있는 프립을 저장해 보세요!"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if frips.count != 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
            StoredGetManager().getFripDetail(targetURL: URL(string: Constant.ALL_FRIP)!, index: cell.idx, header: jwt, vc: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if frips.count != 0 {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    @objc func buttonTap(sender: UIButton!) {
        frips.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        frips = []
        StoredGetManager().getUserFrips(targetURL: Constant.FRIP_LIKE, header: jwt, vc: self)
    }
    
}
