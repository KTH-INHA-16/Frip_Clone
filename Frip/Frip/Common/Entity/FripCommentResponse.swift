import Foundation

struct FripCommentResult: Codable {
    var result:[FripComment]
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct FripComment: Codable{
    var fripReviewIdx: Int
    var fripReview: String
    var rate: String
    var fripReviewPhotoUrl: String
    var isUser: String
    var fripReviewTime: String
    var userBuyFripIdx: Int
    var userBuyFripOption: String
    var userBuyFripSchedule: String
    var fripReviewLike: String
    var fripReviewLikeCnt: Int
    var fripReviewUserIdx: Int
    var fripReviewUserProfileImg: String
    var fripReviewUserNickname: String
    var fripReviewCommentIdx: Int
    var fripReviewComment: String
    var fripReviewCommentTime: String
    var hostIdx: Int
    var hostName: String
    var hostProfileImg: String
}
