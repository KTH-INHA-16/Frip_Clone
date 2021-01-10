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
    
    func getHostFrip(targetURL: URL,index: Int, header: String, vc: HostMainViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(index)")!
        print(header)
        print(url.absoluteString)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: FripDetail.self) { response in
                print(response.result)
                switch response.result {
                case .success(let result):
                    vc.getFripDetail(result.result,index)
                case .failure(let error):
                    print("getMainFrips Failed \(error)")
                }
            }
    }
    
    func getFripComments(targetURL: URL, index: Int,start: Int, end: Int ,header: String, vc:FripCommentViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(index)/reviews?start=\(start)&end=\(end)")!
        print(url.absoluteString)
        AF.request(url,method: .get,parameters: nil,encoding: JSONEncoding.default,headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: FripCommentResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getComments(result.result)
                case .failure(let error):
                    print("getFripComments \(error)")
                }
            }
    }
    
    func getHostInfo(targetURL:URL, hostIdx:Int, header:String,vc:HostMainViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(hostIdx)")!
        AF.request(url,method: .get,parameters: nil,encoding: JSONEncoding.default,headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HostInfoResult.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getHostInfo(result.result)
                case .failure(let error):
                    print("getHostInfo \(error)")
                }
            }
    }
    
    func getHostFrips(targetURL:URL, hostIdx:Int, header:String,vc:HostMainViewController) {
        let url = URL(string: targetURL.absoluteString + "/\(hostIdx)/frips")!
        AF.request(url,method: .get,parameters: nil,encoding: JSONEncoding.default,headers: ["X-ACCESS-TOKEN":header])
            .validate()
            .responseDecodable(of: HomeFrips.self) { response in
                switch response.result {
                case .success(let result):
                    vc.getFrips(result.result)
                case .failure(let error):
                    print("getHostInfo \(error)")
                }
            }
    }
    
 
}
