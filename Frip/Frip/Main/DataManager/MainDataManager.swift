//
//  MainDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/03.
//
import Alamofire

class MainDataManager {
    func searchMainUser(targetUrl: URL,header: String, viewController:MainViewController) {
        AF.request(targetUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":header])
            .validate()
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.successToRequest(result: response.response)
                case .failure(_):
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않음")
                }
            }
    }
}
