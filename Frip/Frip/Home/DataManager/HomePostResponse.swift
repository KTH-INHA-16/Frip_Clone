import Alamofire

class HomePostResponse {
    func fripSave(targetUrl: URL,idx:Int,header: String) {
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
    
    func fripSavingPost(targetUrl: URL,idx:Int,header: String, VC: RecViewController) {
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
    
    func fripSavingDailyPost(targetUrl: URL,idx:Int,header: String, VC: DailyViewController) {
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
    
    func fripSavingBestPost(targetUrl: URL,idx:Int,header: String, VC: BestViewController) {
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
    
    func fripSavingCategorySearch (targetUrl: URL,idx:Int,header: String, VC: CategorySearchViewController) {
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
    
    func fripShowSave (targetUrl: URL,idx:Int,header: String, VC: FripShowViewController) {
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
