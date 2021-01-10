//
//  SearchViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    var idx: Int = 0
    var search: String = ""
    var isFininsh: Bool = false
    var savefrips: [Frip] = []
    var frips:[Frip] = []
    var bigIdx: Int = 0
    var smallIdx:Int = 0
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
    var searchView: UIView = UIView()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(search: String) {
        self.search = search
        super.init(nibName: "SearchViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        searchView.backgroundColor = .systemGray6
        
        titleLabel.text = "검색 결과"
        titleLabel.font = UIFont.NotoSans(.bold, size: 16)
        
        countLabel.font = UIFont.NotoSans(.medium, size: 14)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(UINib(nibName: "NothingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NothingCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SearchGetDataManager().getAllFrips(targetURL: URL(string: Constant.ALL_FRIP)!, search: search, header: jwt, vc: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSearchBar()
    }
    
    func setSearchBar(){
        //서치바 만들기
        let searchBar = UISearchBar()
        searchBar.placeholder = "프립 검색하기"
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        let bar = self.navigationController?.navigationBar.topItem?.titleView as! UISearchBar
        bar.delegate = self
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
    
    func getFrips(_ result:[Frip]) {
        var temp = idx
        for r in result {
            savefrips.append(r)
        }
        if result.count != 0{
            for i in idx..<idx+16 {
                if i < savefrips.count {
                    temp += 1
                    frips.append(savefrips[i])
                } else { break }
            }
        }
        idx = temp
        isFininsh = true
        countLabel.text = "\(savefrips.count)"
        countLabel.sizeToFit()
        print(frips)
        collectionView.reloadData()
    }
    
    func getDetail(_ result: FripDetailInfo,_ index: Int) {
        let vc = FripShowViewController(index, result)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension SearchViewController: UISearchBarDelegate {
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
        print("취소")
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFininsh {
            if frips.count == 0{
                return 1
            } else {
                return frips.count
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isFininsh {
            if frips.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NothingCollectionViewCell", for: indexPath) as! NothingCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                let frip = frips[indexPath.row]
                do {
                    let url = URL(string: frip.fripPhotoUrl)!
                    let data = try Data(contentsOf: url)
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
                return cell
            }
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isFininsh {
            if frips.count == 0{
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            } else {
                return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
            }
        } else {
            return CGSize(width: collectionView.frame.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
        SearchGetDataManager().getFripDetail(targetURL: URL(string: Constant.ALL_FRIP)!, index: cell.idx, header: jwt, vc: self)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var indexPaths: [NSIndexPath] = []
        var temp = idx
        for i in idx..<idx+16 {
            if i < savefrips.count {
                temp += 1
                frips.append(savefrips[i])
                indexPaths.append(NSIndexPath(item: idx, section: 0))
            } else { break }
        }
        if !indexPaths.isEmpty {
            idx = temp
            collectionView.insertItems(at: indexPaths as [IndexPath])
            collectionView.reloadItems(at: indexPaths as [IndexPath])
        }
        
    }
}
