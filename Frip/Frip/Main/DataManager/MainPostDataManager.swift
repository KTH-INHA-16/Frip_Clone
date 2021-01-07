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
                print("우리 서버 성공")
                print("jwt: \(response.result.jwt)")
                VC.successToLogin(result: response)
            case .failure(_):
                print("우리 서버 실패")
                VC.failedToRequest(message: "서버와의 연결이 원활하지 않음")
            }
        }
    }
    
    func postServerJWT(targetUrl: URL,header: String,VC:SceneDelegate) {
        print("header: \(header)")
        AF.request(targetUrl, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
        .validate()
        .responseDecodable(of: AutoLogin.self) { response in
            print("jwt 조회")
            switch response.result {
            case .success(let response):
                print("JWT 성공")
                VC.successJwt(code: response.code)
            case .failure(_):
                print("JWT 실패")
                VC.failedJwt(code: 5000)
            }
        }
    }
}
