//
//  BestViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class BestViewController: BaseViewController {

    @IBOutlet weak var buttonCollectionView: UICollectionView!
    @IBOutlet weak var fripCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    
    var bigCategory: [String] = ["전체","엑티비티","배움","건강·뷰티","모임"]
    var sortText: [String] = ["인기","최신"]
    var frips: [Frip] = []
    var categoryIdx: Int = 0
    var option: Int = 0
    var idx: Int = 0
    var userInfo: [AnyHashable: Any]?
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    let text1 = NSAttributedString(string: "인기순", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font: UIFont.NotoSans(.regular, size: 15)])
    let text2 = NSAttributedString(string: "최신순", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font: UIFont.NotoSans(.regular, size: 15)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frips = []
        
        sortButton.setAttributedTitle(text1, for: .normal)
        Dispatch.DispatchQueue.global(qos: .userInitiated).sync {
            HomeGetResponse().getBestAllFrips(targetURL: URL(string: Constant.ALL_FRIP)!, option: 0, start: idx, end: idx+16, header: jwt, vc: self)
        }
        
        buttonCollectionView.tag = 0
        buttonCollectionView.dataSource = self
        buttonCollectionView.delegate = self
        
        fripCollectionView.tag = 1
        fripCollectionView.dataSource = self
        fripCollectionView.delegate = self
        
        buttonCollectionView.register(UINib(nibName: "BestButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestButtonCollectionViewCell")
        fripCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        fripCollectionView.register(UINib(nibName: "IndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IndicatorCollectionViewCell")
    }
    
    @IBAction func sortButtonTapDown(_ sender: Any) {
        let action = UIAlertController(title: "정렬 기준 선택", message: nil, preferredStyle: .actionSheet)
        let alert1 = UIAlertAction(title: "인기순", style: .default, handler: { _ in
            self.option = 0
            self.idx = 0
            self.frips = []
            self.fripCollectionView.reloadData()
            self.reloadView()
            self.sortButton.setAttributedTitle(self.text1, for: .normal)
        })
        let alert2 = UIAlertAction(title: "후기순", style: .default, handler: { _ in
            self.option = 1
            self.idx = 0
            self.frips = []
            self.fripCollectionView.reloadData()
            self.reloadView()
            self.sortButton.setAttributedTitle(self.text2, for: .normal)
        })
        action.addAction(alert1)
        action.addAction(alert2)
        present(action, animated: true, completion: nil)
    }
    
    func getFrips(results: [Frip]) {
        for res in results {
            frips.append(res)
        }
        var indexPaths: [NSIndexPath] = []
        for i in idx..<idx+results.count {
            indexPaths.append(NSIndexPath(item: i, section: 0))
        }
        idx = idx + results.count
        fripCollectionView.insertItems(at: indexPaths as [IndexPath])
        fripCollectionView.reloadItems(at: indexPaths as [IndexPath])
    }
    
    func reloadView(){
        if self.categoryIdx == 0{
            Dispatch.DispatchQueue.global(qos: .userInitiated).sync {
                HomeGetResponse().getBestAllFrips(targetURL: URL(string: Constant.ALL_FRIP)!, option: self.option, start: self.idx, end: self.idx+16, header: self.jwt, vc: self)
            }
        } else {
            Dispatch.DispatchQueue.global(qos: .userInitiated).sync {
                HomeGetResponse().getBestFrips(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: self.categoryIdx, option: self.option, start: self.idx, end: self.idx+16, header: self.jwt, vc: self)
            }
        }
    }
}

extension BestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestButtonCollectionViewCell", for: indexPath) as! BestButtonCollectionViewCell
            cell.button.text = bigCategory[indexPath.row]
            if categoryIdx == indexPath.row {
                cell.backgroundColor = .systemBlue
                cell.button.textColor = .white
            } else {
                cell.backgroundColor = .systemGray5
                cell.button.textColor = .lightGray
            }
            cell.button.tag = indexPath.row
            return cell
        } else {
            if frips.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndicatorCollectionViewCell", for: indexPath) as! IndicatorCollectionViewCell
                cell.indicator.startAnimating()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                let frip = frips[indexPath.row]
                let url = URL(string: frip.fripPhotoUrl)
                cell.image.kf.setImage(with: url)
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
                cell.idx = frip.fripIdx
                cell.place.text = frip.place
                cell.price.text = frip.price
                cell.point.text = frip.rate
                cell.shortDescription.text = frip.fripHeader
                cell.title.text = frip.fripTitle
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return bigCategory.count
        } else {
            if frips.count == 0{
                return 1
            } else {
                return frips.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0{
            categoryIdx = indexPath.row
            idx = 0
            frips = []
            buttonCollectionView.reloadData()
            fripCollectionView.reloadData()
            if categoryIdx == 0{
                Dispatch.DispatchQueue.global(qos: .userInitiated).sync {
                    HomeGetResponse().getBestAllFrips(targetURL: URL(string: Constant.ALL_FRIP)!, option: option, start: idx, end: idx+16, header: jwt, vc: self)
                }
            } else {
                Dispatch.DispatchQueue.global(qos: .userInitiated).sync {
                    HomeGetResponse().getBestFrips(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: categoryIdx, option: option, start: idx, end: idx+16, header: jwt, vc: self)
                }
            }
        } else {
            if frips.count != 0 {
                let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
                print(cell.idx)
                userInfo = ["fripIdx":cell.idx]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "detail"), object: nil, userInfo: userInfo)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            if bigCategory[indexPath.row].count < 3{
                return CGSize(width: 40, height: 30)
            } else {
                return CGSize(width: 60, height: 30)
            }
        } else {
            if frips.count == 0 {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            } else {
                return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
            }
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            userInfo = ["velocity":"up"]
        } else {
            userInfo = ["velocity":"down"]
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil, userInfo: userInfo)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadView()
    }
}
