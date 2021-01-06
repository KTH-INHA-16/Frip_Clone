//
//  RecViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//
import Foundation
import UIKit

class RecViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let bigText: [String] = ["엑티비티","배움","건강·뷰티","모임"]
    let labelText: [String] = ["아웃도어", "요리", "피트니스", "스터디"]
    let headerText: [String] = ["","가장 인기 있는 프립 🥇", "신규 프립", "후기가 많은 프립"]
    var userInfo: [AnyHashable: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        let bNib = UINib(nibName: "BtnCollectionViewCell", bundle: nil)
        collectionView.register(bNib, forCellWithReuseIdentifier: "BtnCollectionViewCell")
        let mNib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        collectionView.register(mNib, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension RecViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BtnCollectionViewCell", for: indexPath) as? BtnCollectionViewCell else { return UICollectionViewCell() }
            cell.idx = indexPath.row
            cell.button.setImage(UIImage(named: "ButtonImage\(indexPath.row)"), for: .normal)
            cell.label.text = labelText[indexPath.row]
            cell.button.tag = indexPath.row
            cell.button.addTarget(self, action: #selector(roundButtonTap(sender:)), for: .touchDown)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell() }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.bounds.width / 5, height: 70)
        } else {
            return CGSize(width: collectionView.bounds.width / 2 - 10, height: 280)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 0)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0{
            return UICollectionReusableView()
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
            
            header.configure(headerText[indexPath.section])
            header.buttonConfigure(headerText[indexPath.section])
            return header
        }
    }
    
    @objc func roundButtonTap(sender: UIButton!) {
        print("se")
        userInfo = ["bigCategory":bigText[sender.tag],"smallCategory":labelText[sender.tag]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostButton"), object: nil, userInfo: userInfo)
    }
    
}
