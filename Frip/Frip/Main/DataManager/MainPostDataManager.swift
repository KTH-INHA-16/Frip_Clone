//
//  MainPostDataManager.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/04.
//

import Alamofire


class MainPostDataManager {
    func postOurServer(targetUrl: URL,header: String, VC: MainViewController) {
        AF.request(targetUrl, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["NAVER-ACCESS-TOKEN":header])
        .validate()
        .responseDecodable(of: LogIn.self) { response in
            switch response.result {
            case .success(let response):
                VC.successToLogin(result: response)
            case .failure(_):
                VC.failedToRequest(message: "서버와의 연결이 원활하지 않음")
            }
        }
    }
    
    func postServerJWT(targetUrl: URL,header: String,VC:SceneDelegate) {
        AF.request(targetUrl, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
        .validate()
        .responseDecodable(of: AutoLogin.self) { response in
            switch response.result {
            case .success(let response):
                VC.result = response.code
            case .failure(_):
                break
            }
        }
    }
}
