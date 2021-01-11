//
//  FeedPostDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import Foundation
import Alamofire

class FeedPostDataManager {
    var jwt:String {
        return UserDefaults.standard.string(forKey: "userJWT")!
    }
    
    func postFeedLike(url: String,reviewIdx: Int) {
        print(url+"/\(reviewIdx)/likes")
        AF.request(URL(string: url+"/\(reviewIdx)/likes")!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: SaveResult.self) { response in
                switch response.result {
                case .success(_):
                    print("success")
                case .failure(_):
                    print("error")
                }
            }
    }
    
    func postComment(url:String,reviewIdx:Int,message:String,vc:FeedCommentViewController){
        if let text = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let body = ["fripFeedComment":text]
            print(url+"/\(reviewIdx)/comments")
            AF.request(URL(string: url+"/\(reviewIdx)/comments")!, method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
                .validate()
                .responseDecodable(of: CommentPost.self) { response in
                    switch response.result {
                    case .success(let result):
                        switch  result.isSuccess{
                        case true:
                            FeedGetDataManager().getFeedComments(targetURL: Constant.FEED_LIKE, idx: vc.idx, vc: vc)
                        case false:
                            vc.presentAlert(title: "저장 실패")
                        }
                    case .failure(_):
                        print("error")
                    }
                }
        } else {
            vc.presentAlert(title: "검색 불가")
        }
    }
    
    func deleteFeedComments(targetURL:String,idx:Int,commentIdx:Int,vc:FeedCommentViewController) {
        print(URL(string: targetURL+"/\(idx)/comments/\(commentIdx)")?.absoluteString)
        AF.request(URL(string: targetURL+"/\(idx)/comments/\(commentIdx)")!, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: CommentPost.self) { response in
                switch response.result {
                case .success(let result):
                    switch  result.isSuccess{
                    case true:
                        FeedGetDataManager().getFeedComments(targetURL: Constant.FEED_LIKE, idx: idx, vc: vc)
                    case false:
                        vc.presentAlert(title: "삭제 실패")
                    }
                case .failure(_):
                    print("deleteFeedComments error")
                }
            }
    }
}
