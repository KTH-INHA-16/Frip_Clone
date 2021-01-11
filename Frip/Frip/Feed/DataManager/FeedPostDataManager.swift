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
}
