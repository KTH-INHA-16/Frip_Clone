import Alamofire

class HomePostResponse {
    func fripSavingPost(targetUrl: URL,idx:Int,header: String, VC: RecViewController) {
        let url = URL(string: targetUrl.absoluteString+"/\(idx)/likes")!
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: SaveResult.self) { response in
                switch response.result {
                case .success(let response):
                    print("저장 성공")
                case .failure(_):
                    print("저장 실패")
                }
            }
    }
    
    func fripSavingDailyPost(targetUrl: URL,idx:Int,header: String, VC: DailyViewController) {
        let url = URL(string: targetUrl.absoluteString+"/\(idx)/likes")!
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: SaveResult.self) { response in
                switch response.result {
                case .success(let response):
                    print("저장 성공")
                case .failure(_):
                    print("저장 실패")
                }
            }
    }
}
