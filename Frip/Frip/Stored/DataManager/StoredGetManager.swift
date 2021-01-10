//
//  StoredGetManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation
import Alamofire

class StoredGetManager {
    func getUserFrips(targetURL:String,header:String,vc:SaveFripViewController) {
        print(targetURL)
        AF.request(URL(string: targetURL)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: SaveFripResult.self) { response in
                switch response.result {
                case .success(let response):
                    vc.getFrips(response.result)
                case .failure(let error):
                    print("error: \(error)")
                }
            }
    }
    
    func getFripDetail(targetURL:URL,index:Int,header:String,vc:SaveFripViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(index)")!
        print(url.absoluteString)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: FripDetail.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getDetail(result.result, index)
                case .failure(let error):
                    print("error: \(error)")
                }
            }
    }
    
    func getUserHosts(targetURL:String,header:String,vc:SaveHostViewController) {
        AF.request(URL(string: targetURL)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of:SaveHostResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getHosts(result.result)
                case .failure(let error):
                    print("error: \(error)")
                }
            }
    }
}
