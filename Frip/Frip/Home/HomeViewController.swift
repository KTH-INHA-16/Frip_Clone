//
//  HomeViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func touch(_ sender: Any) {
        print(234234)
    }
    
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3, height: self.view.bounds.height-74)
        scrollView.isPagingEnabled = true
        
        let rVC = RecViewController()
        let dVC = DailyViewController()
        let bVC = BestViewController()
        let viewControllers = [ rVC, dVC, bVC ]
        var idx = 0
        for vc in viewControllers {
            let originX = CGFloat(idx) * self.view.bounds.width
            vc.view.frame = CGRect(x:originX,y: 74,width: vc.view.bounds.width,height: self.view.bounds.height-74)
            vc.willMove(toParent: self)
            addChild(vc)
            scrollView.addSubview(vc.view)
            vc.didMove(toParent: self)
            idx += 1
        }
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
