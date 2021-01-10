//
//  HomeViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
    var searchView: UIView = UIView()
    
    var fripIndex: Int = 0
    var fripDetail: FripDetailInfo?
    var bigCategory: String = ""
    var touch = 0
    let text = ["추천","일상","베스트"]
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        searchView.backgroundColor = .systemGray6
        setSearchBar()
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3, height: self.view.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        collectionView.isScrollEnabled = false
        
        let rVC = RecViewController()
        let dVC = DailyViewController()
        let bVC = BestViewController()
        //프로토콜, notification center
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentVC(_:)), name: NSNotification.Name("PostButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollVC(_:)), name: NSNotification.Name("hide"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(detailVC(_:)), name: NSNotification.Name("detail"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func detailVC(_ notification: Notification) {
        guard let idx = notification.userInfo?["fripIdx"] as? Int else {return}
        print("index is: \(idx)")
        fripIndex = idx
        DispatchQueue.global(qos:.userInitiated).sync {
            CommonGetDataManager().getMainFrips(targetURL: URL(string: Constant.ALL_FRIP)!, index: idx, header: jwt, vc: self)
        }
    }
    
    @objc func presentVC(_ notification: Notification) {
        guard let bigCategory = notification.userInfo?["bigCategory"] as? String else {return}
        guard let smallCategory = notification.userInfo?["smallCategory"] as? String else {return}
        let searchVC = CategorySearchViewController(bigCategory, smallCategory)
        searchVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func scrollVC(_ notification: Notification) {
        guard let velo = notification.userInfo?["velocity"] as? String else {return}
        if velo != "up" {
            UIView.animate(withDuration: 0.1, animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.scrollView.frame.origin.y = 138
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.scrollView.frame.origin.y = 88
            })
        }
    }
    
    func setSearchBar(){
        //서치바 만들기
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        searchBar.cornerRadius = 50
        searchBar.placeholder = "검색어를 입력해 주세요"
        //네비게이션에 서치바 넣기
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        let bar = self.navigationController?.navigationBar.topItem?.titleView as! UISearchBar
        bar.delegate = self
        
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
        print(bar.placeholder)
    }
    
    func getResult(_ result: FripDetailInfo) {
        fripDetail = result
        print("show")
        self.navigationController?.pushViewController(FripShowViewController(fripIndex,fripDetail!), animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("hellosdfdsfas")
        self.view.addSubview(searchView)
        let bar = self.navigationController?.navigationBar.topItem?.titleView as! UISearchBar
        bar.setShowsCancelButton(true, animated: false)
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
        print(searchView)
        if let text = searchBar.text {
            let search = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if !search.isEmpty {
                let vc = SearchViewController(search: search)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        touch = Int(scrollView.contentOffset.x) / Int(self.view.frame.width)
        collectionView.reloadData()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            UIView.animate(withDuration: 0.1, animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                scrollView.frame.origin.y = 88
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                scrollView.frame.origin.y = 138
            })
        }
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
