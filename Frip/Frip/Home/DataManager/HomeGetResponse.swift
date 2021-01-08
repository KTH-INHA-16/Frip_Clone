//
//  HomeGetResponse.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import Alamofire

class HomeGetResponse {
    func getMainFrips(targetURL: URL,order: Int, header: String, vc: RecViewController) {
        let url = URL(string: targetURL.absoluteString + "?order=\(order)&main=1")!
        print(url.absoluteString)
        print(header)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.resultFrips(order, result: result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: error")
                }
            }
    }
    
    func getDailyFrips(targetURL: URL,idx: Int,option: Int ,header:String, vc: DailyViewController) {
        let url = URL(string: targetURL.absoluteString+"/\(idx)?main=1&order=\(option)")!
        print(url.absoluteString)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.getResult(res: result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: getDailyFrips error")
                }
            }
    }
    
    func getBestFrips(targetURL: URL,idx: Int,option: Int ,start: Int,end:Int,header:String, vc: BestViewController) {
        let url =  URL(string: targetURL.absoluteString+"/\(idx)?order=\(option)&start=\(start)&end=\(end)")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.getFrips(results: result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: getDailyFrips error")
                }
            }
    }
    
    func getBestAllFrips(targetURL: URL,option: Int ,start: Int,end:Int,header:String, vc: BestViewController) {
        let url =  URL(string: targetURL.absoluteString+"?order=\(option)&start=\(start)&end=\(end)")!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.isSuccess {
                    case true:
                        vc.getFrips(results: result.result)
                    case false:
                        print("no data")
                    }
                case .failure(_):
                    print("error: getDailyFrips error")
                }
            }
    }
}
