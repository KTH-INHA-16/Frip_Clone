//
//  SearchPostDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation
import Alamofire

class SearchPostDataManager {
    func searchSaveFrip (targetUrl: URL,idx:Int,header: String, VC: SearchViewController) {
        let url = URL(string: targetUrl.absoluteString+"/\(idx)/likes")!
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: SaveResult.self) { response in
                switch response.result {
                case .success(_):
                    print("저장 성공")
                case .failure(_):
                    print("저장 실패")
                }
            }
    }
}
