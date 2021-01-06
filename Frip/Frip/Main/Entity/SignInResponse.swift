struct SignInResponse: Decodable {
    var message: String
    var response: UserInfo
}

struct UserInfo: Decodable {
    var birthday: String
    var email:String
    var gender: String
    var mobile: String
    var mobileGlobal: String
    var name: String
    var nickname: String
    var profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case birthday
        case email
        case gender
        case mobile
        case mobileGlobal = "mobile_e164"
        case name
        case nickname
        case profileImage = "profile_image"
    }
    
}
