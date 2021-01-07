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
    
    var count = 20
    var bigCategory: [String] = ["전체","엑티비티","배움","건강·뷰티","모임"]
    var sortText: [String] = ["인기","후기"]
    var idx = 0
    var sortType: Int = 0
    var userInfo: [AnyHashable: Any]?
    
    let text1 = NSAttributedString(string: "인기순", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font: UIFont.NotoSans(.regular, size: 15)])
    let text2 = NSAttributedString(string: "후기순", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font: UIFont.NotoSans(.regular, size: 15)])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortButton.setAttributedTitle(text1, for: .normal)
        
        buttonCollectionView.tag = 0
        buttonCollectionView.dataSource = self
        buttonCollectionView.delegate = self
        
        fripCollectionView.tag = 1
        fripCollectionView.dataSource = self
        fripCollectionView.delegate = self
        
        buttonCollectionView.register(UINib(nibName: "BestButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestButtonCollectionViewCell")
        fripCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    @IBAction func sortButtonTapDown(_ sender: Any) {
        let action = UIAlertController(title: "정렬 기준 선택", message: nil, preferredStyle: .actionSheet)
        let alert1 = UIAlertAction(title: "인기순", style: .default, handler: { _ in
            self.idx = 0
            //파싱 추가
            self.sortButton.setAttributedTitle(self.text1, for: .normal)
        })
        let alert2 = UIAlertAction(title: "후기순", style: .default, handler: { _ in
            self.idx = 1
            //파싱 추가
            self.sortButton.setAttributedTitle(self.text2, for: .normal)
        })
        action.addAction(alert1)
        action.addAction(alert2)
        present(action, animated: true, completion: nil)
    }
}

extension BestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestButtonCollectionViewCell", for: indexPath) as! BestButtonCollectionViewCell
            cell.button.text = bigCategory[indexPath.row]
            if idx == indexPath.row {
                cell.backgroundColor = .systemBlue
                cell.button.textColor = .white
            } else {
                cell.backgroundColor = .systemGray5
                cell.button.textColor = .lightGray
            }
            cell.button.tag = indexPath.row
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return bigCategory.count
        } else {
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0{
            idx = indexPath.row
            buttonCollectionView.reloadData()
            fripCollectionView.reloadData()
        } else {
            
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
            return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
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
        count += 10
        fripCollectionView.reloadData()
    }
}
