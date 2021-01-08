//
//  DailyViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class DailyViewController: BaseViewController {

    @IBOutlet weak var bigCategoryCollectionView: UICollectionView!
    @IBOutlet weak var smallCategoryCollectionView: UICollectionView!
    @IBOutlet weak var showBigCategoryCollectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var category: [String:[String]] = ["엑티비티":["아웃도어","서핑","스포츠","수상레저"],"배움":["공예·DIY","댄스","요리","음료"],"건강·뷰티":["피트니스","요가","필라테스","뷰티"],"모임":["클럽","스터디","토크","게임"]]
    var headerText: [String] = ["인기","신규"]
    var bigCategory: [String] = ["엑티비티","배움","건강·뷰티","모임"]
    var frips: [Frip] = []
    var idx = 0
    var userInfo: [AnyHashable: Any]?
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.borderWidth = 1
        refreshButton.borderColor = .lightGray
        refreshButton.cornerRadius = 5
        
        DispatchQueue.global(qos: .userInitiated).sync {
            HomeGetResponse().getDailyFrips(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: 1, option: 0, header: jwt, vc: self)
            HomeGetResponse().getDailyFrips(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: 1, option: 1, header: jwt, vc: self)
        }
        
        self.view.setGradient(color1: UIColor.gradationBlue1, color2: UIColor.gradationBlue4, bounds: CGRect(x: 0, y: 0, width: self.view.frame.width, height: bigCategoryCollectionView.frame.height + smallCategoryCollectionView.frame.height))
        self.view.addSubview(bigCategoryCollectionView)
        self.view.addSubview(smallCategoryCollectionView)

        bigCategoryCollectionView.tag = 0
        smallCategoryCollectionView.tag = 1
        showBigCategoryCollectionView.tag = 2
        setDelegateAndDataSource([bigCategoryCollectionView,smallCategoryCollectionView,showBigCategoryCollectionView])
        
        bigCategoryCollectionView.register(UINib(nibName: "DailyBigCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DailyBigCollectionViewCell")
        smallCategoryCollectionView.register(UINib(nibName: "DailyBigCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DailyBigCollectionViewCell")
        showBigCategoryCollectionView.register(UINib(nibName: "IndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IndicatorCollectionViewCell")
        showBigCategoryCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        showBigCategoryCollectionView.register(UINib(nibName: "DailyButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DailyButtonCollectionViewCell")
        showBigCategoryCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
    }
    
    @objc func buttonTapDown() {
        userInfo = ["bigCategory": bigCategory[idx],"smallCategory":"전체"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostButton"), object: nil, userInfo: userInfo)
    }
    
    func setDelegateAndDataSource(_ view:[UICollectionView]) {
        for v in view {
            v.dataSource = self
            v.delegate = self
        }
    }
    
    func getResult(res: [Frip]) {
        for r in res { frips.append(r) }
        print("frips.count: \(frips.count)")
        if frips.count >= 8 {
            showBigCategoryCollectionView.reloadData()
        }
    }
    
    @objc func saveButtonTap(_ sender: UIButton!) {
        let save = sender.tag % 10
        let idx = sender.tag / 10
        if save != 0 {
            sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            sender.tintColor = UIColor.saveColor
            HomePostResponse().fripSavingDailyPost(targetUrl: URL(string: Constant.ALL_FRIP)!, idx: idx, header: jwt, VC: self)
            sender.tag = idx * 10 + 0
            print("save")
        } else {
            sender.setImage(UIImage(systemName: "bookmark"), for: .normal)
            sender.tintColor = .white
            HomePostResponse().fripSavingDailyPost(targetUrl: URL(string: Constant.ALL_FRIP)!, idx: idx, header: jwt, VC: self)
            sender.tag = idx * 10 + 1
            print("unsave")
        }
    }
}

extension DailyViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView.tag == 2 {
            if frips.count < 8 {
                return 1
            } else {
                return 3
            }
        }
        else { return 1 }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag < 2 { return 4 }
        else {
            if frips.count < 8 {
                return 1
            } else {
                if section < 2 { return 4 } else { return 1}
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyBigCollectionViewCell", for: indexPath) as! DailyBigCollectionViewCell
            cell.label.text = bigCategory[indexPath.row]
            cell.label.textColor = .white
            if idx == indexPath.row {
                cell.label.font = UIFont.NotoSans(.bold, size: 14)
                cell.border.backgroundColor = .white
            } else {
                cell.label.font = UIFont.NotoSans(.medium, size: 14)
                cell.border.backgroundColor = .lightGray
            }
            return cell
        } else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyBigCollectionViewCell", for: indexPath) as! DailyBigCollectionViewCell
            cell.label.text = category[bigCategory[idx]]![indexPath.row]
            cell.label.font = UIFont.NotoSans(.medium, size: 14)
            cell.label.textColor = .white
            cell.border.isHidden = true
            return cell
        } else {
            if frips.count < 8 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndicatorCollectionViewCell", for: indexPath)
                return cell
            } else {
                if indexPath.section < 2 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                    var frip: Frip = Frip(fripIdx: 0, fripHeader: "", fripTitle: "", price: "", rate: "", isNew: "", isOnly: "", place: "", fripLike: "", fripPhotoUrl: "")
                    var base = 0
                    if indexPath.section != 0 {
                        base = 3
                    }
                    frip = frips[base+indexPath.row]
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
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyButtonCollectionViewCell", for: indexPath) as! DailyButtonCollectionViewCell
                    cell.button.setTitle("n개의 \(bigCategory[idx]) 전체보기", for: .normal)
                    cell.button.addTarget(self, action: #selector(buttonTapDown), for: .touchDown)
                    return cell
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            idx = indexPath.row
            frips = []
            bigCategoryCollectionView.reloadData()
            smallCategoryCollectionView.reloadData()
            showBigCategoryCollectionView.reloadData()
            DispatchQueue.global(qos: .userInitiated).sync {
                HomeGetResponse().getDailyFrips(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: idx+1, option: 0, header: jwt, vc: self)
                HomeGetResponse().getDailyFrips(targetURL: URL(string: Constant.FRIP_CATEGORY)!, idx: idx+1, option: 1, header: jwt, vc: self)
            }
        } else if collectionView.tag == 1{
            userInfo = ["bigCategory": bigCategory[idx],"smallCategory":category[bigCategory[idx]]![indexPath.row]]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostButton"), object: nil, userInfo: userInfo)
        } else {
            if frips.count >= 8{
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag == 2{
            if frips.count < 8 {
                return UICollectionReusableView()
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
                header.configure("\(headerText[indexPath.section]) \(bigCategory[idx])")
                header.buttonConfigure("전체보기")
                return header
            }
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView.tag == 2 {
            if frips.count < 8{
                return CGSize(width: collectionView.bounds.width, height: 0)
            } else {
                if section < 2 {
                    return CGSize(width: collectionView.bounds.width, height: 70)
                } else {
                    return CGSize(width: collectionView.bounds.width, height: 0)
                }
            }
        }
        else { return CGSize(width: collectionView.bounds.width, height: 0) }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            return CGSize(width: collectionView.frame.width / 4, height: 50)
        } else if collectionView.tag == 1{
            return CGSize(width: collectionView.frame.width / 4, height: 60)
        } else {
            if frips.count < 8 {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            } else {
                if indexPath.section < 2 {
                    return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
                } else {
                    return CGSize(width: collectionView.frame.width, height: 50)
                }
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
    
}
