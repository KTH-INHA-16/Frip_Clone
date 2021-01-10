//
//  BuyGetDataManater.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation
import Alamofire

class BuyGetDataManager  {
    func getFripOptions(targetURL: URL,fripIdx: Int, header: String,vc:BuyOptionViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(fripIdx)/options")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: Options.self) { response in
                switch response.result {
                case .success(let result):
                    print(result)
                    vc.getOptions(result.result)
                case .failure(let error):
                    print("getFripOptions error:\(error)")
                }
            }
    }
}
