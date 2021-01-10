import UIKit

class CategoryViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let category: [[String]] = [["아웃도어","서핑","스포츠","수상레저"],["공예·DIY","댄스","요리","음료"],["피트니스","요가","필라테스","뷰티"],["클럽","스터디","토크","게임"]]
    let bigCategory: [String] = ["🏃‍♂️엑티비티","🍰배움","✨건강·뷰티","👫모임"]
    let bigText: [String] = ["엑티비티","배움","건강·뷰티","모임"]
    var searchView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        searchView.backgroundColor = .systemGray6

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cateNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(cateNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        
        setSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

}

extension CategoryViewController: UISearchBarDelegate {
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

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.bigCategory = "엑티비티"
            cell.littleCategory = category[0][indexPath.row]
            cell.label.text = cell.littleCategory
            cell.view.backgroundColor = UIColor.activityColor
            return cell
        case 1:
            cell.bigCategory = "배움"
            cell.littleCategory = category[1][indexPath.row]
            cell.label.text = cell.littleCategory
            cell.view.backgroundColor = UIColor.learningColor
            return cell
        case 2:
            cell.bigCategory = "건강뷰티"
            cell.littleCategory = category[2][indexPath.row]
            cell.label.text = cell.littleCategory
            cell.view.backgroundColor = UIColor.healthColor
            return cell
        case 3:
            cell.bigCategory = "모임"
            cell.littleCategory = category[3][indexPath.row]
            cell.label.text = cell.littleCategory
            cell.view.backgroundColor = UIColor.greetingColor
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let big: String = bigText[indexPath.section]
        let small: String = category[indexPath.section][indexPath.row]
        let vc = CategorySearchViewController(big,small)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.configure(bigCategory[indexPath.section])
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 50)
    }
}
