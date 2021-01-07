import Alamofire

struct Constant {
    static let NAVER_LOGIN_URL = "https://openapi.naver.com/v1/nid/me"
    static let BASE_URL = "https://juna052.shop:8000"
    static let LOGIN_URL = BASE_URL + "/users"
    static let AUTO_LOGIN_URL = BASE_URL + "/users/auto-login"
    static let ALL_FRIP = BASE_URL + "/frips"
    static let FRIP_CATEGORY = ALL_FRIP + "/categories"
}
