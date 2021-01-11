//
//  FeedCommentViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import UIKit

class FeedCommentViewController: BaseViewController {
    
    var idx:Int = 0
    var isKeyBoard: Bool = false
    var comments:[Comment] = []
    var myInfo: MyInfo = MyInfo(userIdx: 0, userNickname: "", profileImg: "", reviewCnt: 0, feedCnt: 0)

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var commentView: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    init(_ idx:Int) {
        self.idx = idx
        super.init(nibName: "FeedCommentViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentView.cornerRadius = commentView.bounds.width / 20
        userImage.cornerRadius = userImage.bounds.width * 0.5
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FeedCommentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCommentCollectionViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        FeedGetDataManager().getFeedComments(targetURL: Constant.FEED_LIKE, idx: idx, vc: self)
        FeedGetDataManager().getMyInfo(targetURL: Constant.MY_PAGE, vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.commentView.endEditing(true) }
    
    @IBAction func registerTapDown(_ sender: Any) {
        self.commentView.endEditing(true)
        guard let text = commentView.text else {
            self.presentAlert(title: "검색어 입력")
            return
        }
        if text.count > 50 {
            self.presentAlert(title: "50글자 초과!")
        } else {
            FeedPostDataManager().postComment(url: Constant.ALL_FEED, reviewIdx: idx, message: text, vc: self)
        }
    }
    
    func getResult(_ result:[Comment]) {
        comments = result
        collectionView.reloadData()
    }
    
    func getMyPhoto(_ result: MyInfo) {
        myInfo = result
        userImage.kf.setImage(with: URL(string: myInfo.profileImg))
    }
    
    @objc func textViewMoveUp(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isKeyBoard == false {
                self.view.frame.origin.y -= (keyboardSize.height - 75)
                isKeyBoard = true
            }
        }
    }
    
    @objc func textViewMoveDown(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isKeyBoard == true {
                self.view.frame.origin.y += (keyboardSize.height - 75)
                isKeyBoard = false
            }
        }
    }
    
    @objc func deleteTapDown(_ sender: UIButton!) {
        let commentIdx = sender.tag
        FeedPostDataManager().deleteFeedComments(targetURL: Constant.ALL_FEED, idx: idx, commentIdx: commentIdx, vc: self)
    }
}

extension FeedCommentViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCommentCollectionViewCell", for: indexPath) as! FeedCommentCollectionViewCell
        if comments.count != 0 {
            cell.image.kf.setImage(with: URL(string: comments[indexPath.row].userProfileImg))
            cell.name.text = comments[indexPath.row].userNickname
            cell.comment.text = comments[indexPath.row].fripFeedComment
            cell.time.text = comments[indexPath.row].fripFeedCommentTime
            cell.name.sizeToFit()
            cell.comment.sizeToFit()
            cell.time.sizeToFit()
            cell.removeButton.tag = comments[indexPath.row].fripFeedCommentIdx
            cell.comment.cornerRadius = cell.comment.bounds.width / 20
            if comments[indexPath.row].isUser == "Y" {
                cell.removeButton.isHidden = false
                cell.removeButton.isEnabled = true
            } else {
                cell.removeButton.isHidden = true
                cell.removeButton.isEnabled = false
            }
            cell.removeButton.addTarget(self, action: #selector(deleteTapDown(_:)), for: .touchDown)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90)
    }
}
