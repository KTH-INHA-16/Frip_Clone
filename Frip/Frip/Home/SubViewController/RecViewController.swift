//
//  RecViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//
import Foundation
import UIKit
import Kingfisher

class RecViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let bigText: [String] = ["엑티비티","배움","건강·뷰티","모임"]
    let labelText: [String] = ["아웃도어", "요리", "피트니스", "스터디"]
    let headerText: [String] = ["","가장 인기 있는 프립 🥇", "신규 프립", "후기가 많은 프립"]
    var recFrips: [Frip] = []
    var newFrips: [Frip] = []
    var commentFrips: [Frip] = []
    var userInfo: [AnyHashable: Any]?
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFrips(options: [2,1,3], header: jwt, url: URL(string: Constant.ALL_FRIP)!)
        
        self.navigationController?.isNavigationBarHidden = true
        
        let bNib = UINib(nibName: "BtnCollectionViewCell", bundle: nil)
        collectionView.register(bNib, forCellWithReuseIdentifier: "BtnCollectionViewCell")
        let mNib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        collectionView.register(mNib, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getFrips(options: [Int], header:String, url:URL) {
        recFrips = []
        newFrips = []
        commentFrips = []
        for option in options {
            print(option)
            DispatchQueue.global(qos: .userInitiated).sync {
                HomeGetResponse().getMainFrips(targetURL: url, order: option, header: header, vc: self)
            }
        }
    }
    
    func resultFrips(_ option: Int, result: [Frip]) {
        if option == 2{
            recFrips = result
            collectionView.reloadData()
            print("recFrips: \(recFrips)")
        } else if option == 1{
            newFrips = result
            collectionView.reloadData()
        } else {
            commentFrips = result
            collectionView.reloadData()
        }
    }
    
    @objc func headerButtonTapDown(_ sender:UIButton!) {
        userInfo = ["sort":sender.tag]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSearch"), object: nil, userInfo: userInfo)
    }

}

extension RecViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 4 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 4 }
        else if section == 1{ return recFrips.count }
        else if section == 2 { return newFrips.count }
        else { return commentFrips.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BtnCollectionViewCell", for: indexPath) as? BtnCollectionViewCell else { return UICollectionViewCell() }
            cell.idx = indexPath.row
            cell.button.borderColor = .white
            cell.button.borderWidth = 0
            cell.button.setImage(UIImage(named: "\(indexPath.row+1)"), for: .normal)
            cell.label.text = labelText[indexPath.row]
            cell.button.tag = indexPath.row
            cell.button.addTarget(self, action: #selector(roundButtonTap(sender:)), for: .touchDown)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell() }
            var frip: Frip = Frip(fripIdx: 0, fripHeader: "", fripTitle: "", price: "", rate: "", isNew: "", isOnly: "", place: "", fripLike: "", fripPhotoUrl: "")
            if indexPath.section == 1 { frip = recFrips[indexPath.row] }
            else if indexPath.section == 2 { frip = newFrips[indexPath.row] }
            else { frip = commentFrips[indexPath.row] }
            let url = URL(string: frip.fripPhotoUrl)
            cell.image.kf.setImage(with: url)
                //킹 피셔 라이브러리 -> 오픈 소스
            cell.saveButton.tag = frip.fripIdx
            if frip.fripLike == "Y" {
                cell.saveButton.tag = cell.saveButton.tag * 10 + 1
                cell.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                cell.saveButton.tintColor = UIColor.saveColor
            } else {
                cell.saveButton.tag = cell.saveButton.tag * 10 + 0
                cell.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                cell.saveButton.tintColor = .white
            }
            print(frip)
            cell.idx = frip.fripIdx
            cell.place.text = frip.place
            cell.price.text = frip.price
            cell.point.text = frip.rate
            cell.shortDescription.text = frip.fripHeader
            cell.title.text = frip.fripTitle
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
            print(cell.idx)
            userInfo = ["fripIdx":cell.idx]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "detail"), object: nil, userInfo: userInfo)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.bounds.width / 4, height: 90)
        } else {
            return CGSize(width: collectionView.bounds.width / 2 - 5, height: 280)
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
            header.button.tag = indexPath.section
            header.button.addTarget(self, action: #selector(headerButtonTapDown(_:)), for: .touchDown)
            return header
        }
    }
    
    @objc func roundButtonTap(sender: UIButton!) {
        print("se")
        userInfo = ["bigCategory":bigText[sender.tag],"smallCategory":labelText[sender.tag]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostButton"), object: nil, userInfo: userInfo)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            userInfo = ["velocity":"up"]
        } else {
            userInfo = ["velocity":"down"]
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil, userInfo: userInfo)
    }
    
}
