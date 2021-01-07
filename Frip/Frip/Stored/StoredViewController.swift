//
//  StoredViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/03.
//

import UIKit

class StoredViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    var touch = 0
    var text = ["프립","호스트"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 2, height: self.view.bounds.height)
        scrollView.delegate = self
        let hVC = SaveHostViewController()
        let fVC = SaveFripViewController()
        let viewControllers = [ fVC, hVC ]
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

}

extension StoredViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        touch = Int(scrollView.contentOffset.x) / Int(self.view.frame.width)
        collectionView.reloadData()
    }
}

extension StoredViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCollectionViewCell", for: indexPath) as! labelCollectionViewCell
        cell.label.text = text[indexPath.row]
        cell.label.font = UIFont.NotoSans(.regular, size: 15)
        if touch == indexPath.row {
            cell.border.backgroundColor = .systemBlue
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
        return CGSize(width: self.view.frame.width/2 , height: collectionView.frame.height)
    }
    
}
