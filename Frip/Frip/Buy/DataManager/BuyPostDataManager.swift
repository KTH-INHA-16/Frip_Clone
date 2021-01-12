//
//  BuyPostDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/12.
//

import Foundation
import Alamofire

class BuyPostDataManager {
    var jwt:String {
        return UserDefaults.standard.string(forKey: "userJWT")!
    }
    
    func postBuyFrip(targetURL:String,fripIdx:Int,option:Int,vc:BuyOptionViewController) {
        let body = ["fripOptionIdx": option,"count": 1]
        AF.request(URL(string: targetURL+"/\(fripIdx)/buy")!, method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":jwt])
            .validate()
            .responseDecodable(of: BuyResult.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.postSuccess()
                    case false:
                        vc.presentAlert(title: "구매 실패")
                    }
                case .failure(_):
                    print("error")
                }
            }
            
    }
}
