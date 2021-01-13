import Alamofire

struct Constant {
    static let NAVER_LOGIN_URL = "https://openapi.naver.com/v1/nid/me"
    static let BASE_URL = "https://juna052.shop:8000"
    static let LOGIN_URL = BASE_URL + "/users"
    static let AUTO_LOGIN_URL = BASE_URL + "/users/auto-login"
    static let ALL_FRIP = BASE_URL + "/frips"
    static let FRIP_CATEGORY = ALL_FRIP + "/categories"
    static let HOST = BASE_URL + "/hosts"
    static let FRIP_LIKE = ALL_FRIP + "/likes"
    static let HOST_LIKE = BASE_URL + "/hosts/likes"
    static let ALL_FEED = BASE_URL + "/reviews/feeds"
    static let FEED_LIKE =  BASE_URL + "/reviews"
    static let MY_PAGE = BASE_URL + "/users/mypage"
    static let MY_PAGE_FRIP = BASE_URL  + "/users/frips"
    static let COMMENT_PAGE = BASE_URL + "/reviews"
}
