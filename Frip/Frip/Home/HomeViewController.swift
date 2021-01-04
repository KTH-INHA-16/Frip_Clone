//
//  HomeViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit
import SwipeViewController

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    var touch = 0
    let text = ["추천","일상","베스트"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3, height: self.view.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        let rVC = RecViewController()
        let dVC = DailyViewController()
        let bVC = BestViewController()
        let viewControllers = [ rVC, dVC, bVC ]
        var idx = 0
        for vc in viewControllers {
            let originX = CGFloat(idx) * self.view.bounds.width
            vc.view.frame = CGRect(x:originX,y: 0,width: vc.view.bounds.width,height: vc.view.bounds.height)
            vc.willMove(toParent: self)
            addChild(vc)
            scrollView.addSubview(vc.view)
            vc.didMove(toParent: self)
            idx += 1
        }
        
        collectionView.register(UINib(nibName: "labelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "labelCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setSearchBar(){
        //서치바 만들기
        let searchBar = UISearchBar()
        searchBar.cornerRadius = 50
        searchBar.placeholder = "검색어를 입력해 주세요"
        //네비게이션에 서치바 넣기
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = UIColor.systemGroupedBackground
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.black
            //왼쪽 아이콘 이미지넣기
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트컬러 정하기
                leftView.tintColor = UIColor.darkGray
            }
            //오른쪽 x버튼 이미지넣기
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트 정하기
                rightView.tintColor = UIColor.darkGray
            }
        }
    }

}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        touch = Int(scrollView.contentOffset.x) / Int(self.view.frame.width)
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCollectionViewCell", for: indexPath) as! labelCollectionViewCell
        cell.label.text = text[indexPath.row]
        cell.label.font = UIFont.NotoSans(.regular, size: 15)
        if touch == indexPath.row {
            cell.border.backgroundColor = .black
            cell.label.textColor = .black
        } else {
            cell.border.backgroundColor = .white
            cell.label.textColor = .lightGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        touch = indexPath.row
        collectionView.reloadData()
        scrollView.contentOffset.x = CGFloat(indexPath.row) * self.view.frame.width
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/3, height: collectionView.frame.height)
    }
    
}
