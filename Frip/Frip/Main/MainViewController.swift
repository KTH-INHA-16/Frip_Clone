import UIKit
import NaverThirdPartyLogin
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var naverLoginButton: UIButton!
    
    var userInfo: UserInfo = UserInfo(birthday: "", email: "", gender: "", mobile: "", mobileGlobal: "", name: "", nickname: "", profileImage: "")
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        greetingLabel.font = UIFont.NotoSans(.bold, size: 20)
        
        descriptionLabel.text = "지금 프립 가입하고 5만원 상당의 \n 쿠폰팩 받아가세요"
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        warningLabel.font = UIFont.NotoSans(.regular, size: 15)
        warningLabel.text = "로그인시 어플리케이션\n 이용가능"
        warningLabel.textAlignment = .center
        warningLabel.numberOfLines = 0
        warningLabel.textColor = .systemGray
    }
    
    @IBAction func naverLoginTapAction(_ sender: Any) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
    func successToRequest(result: UserInfo) {
        userInfo = result
        print(userInfo)
    }
}

extension MainViewController: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
    }

    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        getNaverInfo()
    }

    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.refreshToken = loginInstance?.accessToken
    }

    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
    }

    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
        failedToRequest(message: "서버와의 연결이 원활하지 않음")
        
    }
    
    private func getNaverInfo() {
        showIndicator()
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
          return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        let url = URL(string: Constant.NAVER_LOGIN_URL)!
        
        let authorization = "\(tokenType) \(accessToken)"
        MainDataManager().searchMainUser(targetUrl: url, header: authorization, viewController: self)
        dismissIndicator()
      }
    
}
