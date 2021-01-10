//
//  SearchGetDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation
import Alamofire

class SearchGetDataManager {
    func getAllFrips(targetURL:URL,search:String,header:String,vc:SearchViewController) {
        let url = URL(string: targetURL.absoluteString + "?search=\(search)")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.getFrips(result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: error")
                }
            }
        
    }
    
    func getFripDetail(targetURL:URL,index:Int,header:String,vc:SearchViewController) {
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
    
    func getFripDetail(targetURL:URL,index:Int,header:String,vc:RecSearchViewController) {
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
    
    func getDailyFripDetail(targetURL:URL,index:Int,header:String,vc:DailySearchViewController) {
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
    
    func getFripRecVC(targetURL:URL,sort:Int,header:String,vc:RecSearchViewController) {
        let url = URL(string: targetURL.absoluteString + "?order=\(sort)&start=0&end=16")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.getResult(result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: error")
                }
            }
    }
    
    func getFripDailyVC(targetURL:URL,categoryIdx:Int,sort:Int,header:String,vc:DailySearchViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(categoryIdx)?order=\(sort)&start=0&end=16")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.getResult(result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: error")
                }
            }
    }
}
