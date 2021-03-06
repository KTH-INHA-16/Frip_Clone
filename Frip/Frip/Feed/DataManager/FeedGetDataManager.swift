//
//  FeedGetDataManager.swift
//  Frip
//
//  Created by κΉνν on 2021/01/11.
//

import Foundation
import Alamofire

class FeedGetDataManager {
    var jwt:String {
        return UserDefaults.standard.string(forKey: "userJWT")!
    }
    
    func getAllFeed(targetURL:String,vc:FeedViewController) {
        AF.request(URL(string: targetURL)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: FeedResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getResult(result.result)
                case .failure(_):
                    print("error")
                }
            }
    }
    
    func getFripTitle(targetURL:String,fripIdx:Int,vc:FeedViewController) {
        AF.request(URL(string: targetURL+"/\(fripIdx)")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: FripDetail.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getTitleResult(result.result.fripTitle)
                case .failure(_):
                    print("error: ")
                }
            }
    }
    
    func goShowFrip(targetURL:String,fripIdx:Int,vc:FeedViewController) {
        AF.request(URL(string: targetURL+"/\(fripIdx)")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: FripDetail.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getResult(result.result, fripIdx)
                case .failure(_):
                    print("error:")
                }
        }
    }
    
    func getFeedComments(targetURL:String,idx:Int,vc:FeedCommentViewController) {
        print(URL(string: targetURL+"/\(idx)/feeds/comments")?.absoluteString)
        AF.request(URL(string: targetURL+"/\(idx)/feeds/comments")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: CommentResults.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getResult(result.result)
                case .failure(_):
                    print("error:")
                }
            }
    }
    
    func getMyInfo(targetURL:String,vc:FeedCommentViewController) {
        AF.request(URL(string: targetURL)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: CommentMyResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getMyPhoto(result.result)
                case .failure(_):
                    print("error:")
                }
            }
    }
}
