//
//  CategorySearchViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/05.
//

import UIKit

class CategorySearchViewController: BaseViewController {

    @IBOutlet weak var upperCollectionView: UICollectionView!
    @IBOutlet weak var downCollectionView: UICollectionView!
    @IBOutlet weak var bigCategoryButton: UIButton!
    
    var category: [String:[String]] = ["엑티비티":["전체","아웃도어","서핑","스포츠","수상레저"],"배움":["전체","공예·DIY","댄스","요리","음료"],"건강·뷰티":["전체","피트니스","요가","필라테스","뷰티"],"모임":["전체","클럽","스터디","토크","게임"]]
    var frips:[Any] = []
    
    var bigCategory: String = ""
    var smallCategory: String = ""
    
    init(_ bigCategory:String,_ smallCategory: String) {
        self.bigCategory = bigCategory
        self.smallCategory = smallCategory
        super.init(nibName: "CategorySearchViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        bigCategoryButton.setTitle("\(bigCategory) ", for: .normal)
        
        upperCollectionView.tag = 0
        upperCollectionView.dataSource = self
        upperCollectionView.delegate = self
        
        downCollectionView.tag = 1
        downCollectionView.delegate = self
        downCollectionView.dataSource = self
        
        upperCollectionView.register(UINib(nibName: "SmallCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SmallCategoryCollectionViewCell")
        downCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
}

extension CategorySearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 5
        } else {
            return frips.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallCategoryCollectionViewCell", for: indexPath) as! SmallCategoryCollectionViewCell
            cell.label.text = category[bigCategory]![indexPath.row]
            if smallCategory == category[bigCategory]![indexPath.row] {
                cell.label.textColor = .systemBlue
            } else {
                cell.label.textColor = .black
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            smallCategory = category[bigCategory]![indexPath.row]
            collectionView.reloadData()
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            if category[bigCategory]![indexPath.row].count > 2 {
                return CGSize(width: 65, height: 30)
            } else {
                return CGSize(width: 40, height: 30)
            }
        } else  {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
        }
    }
}
