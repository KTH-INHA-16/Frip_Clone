//
//  MyInfoGetDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/12.
//

import Foundation
import Alamofire

class MyInfoGetDataManager {
    var jwt:String {
        return UserDefaults.standard.string(forKey: "userJWT")!
    }
    
    func getMyInfo(targetURL:String,vc:MyInfoViewController) {
        AF.request(URL(string: targetURL)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: MyInfoResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getUser(result.result)
                case .failure(_):
                    print("error:")
                }
            }
    }
    
    func getMyFrips(targetURL:String,vc:MyInfoViewController) {
        AF.request(URL(string: targetURL)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: UserFripResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getFrips(result.result)
                case .failure(_):
                    print("error:")
                }
            }
    }
}
