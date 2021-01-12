import Foundation

struct MyInfoResult: Codable {
    var result: User
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct User: Codable {
    var userIdx : Int
    var userNickname : String
    var profileImg : String
    var reviewCnt : Int
    var feedCnt : Int
}

struct UserFripResult: Codable {
    var result : [UserFrip]
    var isSuccess : Bool
    var code : Int
    var message : String
}

struct UserFrip: Codable {
    var fripIdx: Int
    var fripHeader: String
    var fripTitle: String
    var price: String
    var rate: String
    var isNew: String
    var isOnly: String
    var place: String
    var fripLike: String
    var fripPhotoUrl: String
    var userBuyFripIdx: Int
    var userBuyFripOption: String
    var userBuyFripSchedule: String
    var count: Int
}
