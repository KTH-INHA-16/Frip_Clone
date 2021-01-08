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
    var option = [[1,5,6,7,8],[2,9,10,11,12],[3,13,14,15,16],[4,17,18,19,20]]
    var frips:[Frip] = []
    var fripIdx: Int = 0
        
    var bigCategory: String = ""
    var smallCategory: String = ""
    var bigCategoryIdx: Int = 0
    var smallCategoryIdx: Int = 0
    var userInfo: [AnyHashable: Any]?
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    init(_ bigCategory:String,_ smallCategory: String) {
        self.bigCategory = bigCategory
        self.smallCategory = smallCategory
        switch bigCategory {
        case "엑티비티":
            bigCategoryIdx = 0
        case "배움":
            bigCategoryIdx = 1
        case "건강·뷰티":
            bigCategoryIdx = 2
        case "모임":
            bigCategoryIdx = 3
        default:
            bigCategoryIdx = 0
        }
        var idx = 0
        for temp in category[bigCategory]! {
            if temp == smallCategory {
                smallCategoryIdx = idx
            }
            idx += 1
        }
        super.init(nibName: "CategorySearchViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        bigCategoryButton.setTitle("\(bigCategory) ", for: .normal)
        
        CategorySearchGetManager().getDetailCategory(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: option[bigCategoryIdx][smallCategoryIdx], start: fripIdx, end: fripIdx + 16, header: jwt, vc: self)
        
        upperCollectionView.tag = 0
        upperCollectionView.dataSource = self
        upperCollectionView.delegate = self
        
        downCollectionView.tag = 1
        downCollectionView.delegate = self
        downCollectionView.dataSource = self
        
        upperCollectionView.register(UINib(nibName: "SmallCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SmallCategoryCollectionViewCell")
        downCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        downCollectionView.register(UINib(nibName: "IndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IndicatorCollectionViewCell")
        
    }
    
    func getFrips(results: [Frip]) {
        for res in results {
            frips.append(res)
        }
        var indexPaths: [NSIndexPath] = []
        for i in fripIdx..<fripIdx+results.count {
            indexPaths.append(NSIndexPath(item: i, section: 0))
        }
        fripIdx = fripIdx + results.count
        downCollectionView.insertItems(at: indexPaths as [IndexPath])
        downCollectionView.reloadItems(at: indexPaths as [IndexPath])
    }
    
    @objc func saveButtonTap(_ sender: UIButton!) {
        let save = sender.tag % 10
        let idx = sender.tag / 10
        if save != 0 {
            sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            sender.tintColor = UIColor.saveColor
            HomePostResponse().fripSavingCategorySearch(targetUrl: URL(string: Constant.ALL_FRIP)!, idx: idx, header: jwt, VC: self)
            sender.tag = idx * 10 + 0
            print("save")
        } else {
            sender.setImage(UIImage(systemName: "bookmark"), for: .normal)
            sender.tintColor = .white
            HomePostResponse().fripSavingCategorySearch(targetUrl: URL(string: Constant.ALL_FRIP)!, idx: idx, header: jwt, VC: self)
            sender.tag = idx * 10 + 1
            print("unsave")
        }
    }
}

extension CategorySearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 5
        } else {
            if frips.count == 0{
                return 1
            } else {
                return frips.count
            }
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
            if frips.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndicatorCollectionViewCell", for: indexPath) as! IndicatorCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                let frip = frips[indexPath.row]
                do {
                    let url = URL(string: frip.fripPhotoUrl)!
                    let realUrl = URL(string: "https://dummyimage.com"+url.relativePath)!
                    let data = try Data(contentsOf: realUrl)
                    cell.image.image = UIImage(data: data)
                } catch { print("image load error") }
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
                cell.saveButton.addTarget(self, action: #selector(saveButtonTap(_:)), for: .touchDown)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            smallCategory = category[bigCategory]![indexPath.row]
            var idx = 0
            for temp in category[bigCategory]! {
                if temp == smallCategory {
                    smallCategoryIdx = idx
                }
                idx += 1
            }
            upperCollectionView.reloadData()
            downCollectionView.reloadData()
            frips = []
            fripIdx = 0
            CategorySearchGetManager().getDetailCategory(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: option[bigCategoryIdx][smallCategoryIdx], start: fripIdx, end: fripIdx, header: jwt, vc: self)
        } else {
            if frips.count != 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                userInfo = ["fripIdx": cell.idx]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "detail"), object: nil, userInfo: userInfo)
            }
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
            if frips.count == 0{
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            } else {
                return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        CategorySearchGetManager().getDetailCategory(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: option[bigCategoryIdx][smallCategoryIdx], start: fripIdx, end: fripIdx + 16, header: jwt, vc: self)
    }
}
