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
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
    var searchView: UIView = UIView()
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
        
        searchView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        searchView.backgroundColor = .systemGray6
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        setSearchBar()
    }
    
    
    func setSearchBar(){
        //서치바 만들기
        print("setSearch Bar")
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        searchBar.placeholder = "프립 검색하기"
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        let bar = self.navigationController?.navigationBar.topItem?.titleView as! UISearchBar
        bar.delegate = self
        print(bar)
        //네비게이션에 서치바 넣기
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = UIColor.white
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.black
            //왼쪽 아이콘 이미지넣기
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트컬러 정하기
                leftView.tintColor = UIColor.black
            }
            //오른쪽 x버튼 이미지넣기
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트 정하기
                rightView.tintColor = UIColor.black
            }
        }
    }
    
    func getFrips(results: [Frip]) {
        for res in results {
            frips.append(res)
        }
//        var indexPaths: [NSIndexPath] = []
//        for i in fripIdx..<fripIdx+results.count {
//            indexPaths.append(NSIndexPath(item: i, section: 0))
//        }
//        fripIdx = fripIdx + results.count
//        downCollectionView.insertItems(at: indexPaths as [IndexPath])
//        downCollectionView.reloadItems(at: indexPaths as [IndexPath])
        downCollectionView.reloadData()
    }
    
    func getDetail(_ result: FripDetailInfo,_ index: Int) {
        let vc = FripShowViewController(index, result)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension CategorySearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("hellosdfdsfas")
        self.view.addSubview(searchView)
        let bar = self.navigationController?.navigationBar.topItem?.titleView as! UISearchBar
        bar.showsCancelButton = true
        if let cancelButton = bar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("취소", for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
        }

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.removeFromSuperview()
        let bar = self.navigationController?.navigationBar.topItem?.titleView as! UISearchBar
        bar.endEditing(true)
        bar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            let search = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if !search.isEmpty {
                let vc = SearchViewController(search: search)
                self.navigationController?.pushViewController(vc, animated: true)
            }
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
            CategorySearchGetManager().getDetailCategory(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: option[bigCategoryIdx][smallCategoryIdx], start: fripIdx, end: fripIdx+16, header: jwt, vc: self)
        } else {
            if frips.count != 0{
                let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
                CategorySearchGetManager().getFripDetail(targetURL: URL(string: Constant.ALL_FRIP)!, index: cell.idx, header: jwt, vc: self)
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
