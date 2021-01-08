//
//  CategorySearchGetManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import Alamofire

class CategorySearchGetManager {
    func getDetailCategory(targetURL: URL,idx: Int ,start: Int,end:Int,header:String, vc: CategorySearchViewController) {
        let url =  URL(string: targetURL.absoluteString+"/\(idx)?order=0&start=\(start)&end=\(end)")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        print("getDetailCategory success")
                        vc.getFrips(results: result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: getDetailCategory error")
                }
            }
    }
}
