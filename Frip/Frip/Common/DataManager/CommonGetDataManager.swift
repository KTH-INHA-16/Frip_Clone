//
//  CommonGetDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import Alamofire

class CommonGetDataManager {
    func getMainFrips(targetURL: URL,index: Int, header: String, vc: HomeViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(index)")!
        print(header)
        print(url.absoluteString)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: FripDetail.self) { response in
                print(response.result)
                switch response.result {
                case .success(let result):
                    vc.getResult(result.result)
                case .failure(let error):
                    print("getMainFrips Failed \(error)")
                }
            }
    }
}
