//
//  FripDetailResponse.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import Foundation

struct FripDetail: Codable {
    var isSuccess: Bool
    var code :Int
    var message: String
    var result: FripDetailInfo
}

struct FripDetailInfo: Codable {
    var fripIdx : Int
    var hostIdx : Int
    var hostName : String
    var hostIntroduction : String
    var profileImgUrl : String
    var hostFripCnt: Int
    var hostLikeCnt: Int
    var fripPhotoUrl: String
    var fripHeader: String
    var fripTitle: String
    var fripLike: String
    var fripLikeUserCnt: Int
    var price: String
    var fripSchedule: String
    var fripScheduleCnt: Int
    var fristFripSchedule: String?
    var place: String
    var rate: String
    var fripReviewCnt: String
    var fripReviewPercent: String
    var fripIntroduction: String
    var includeThing: String
    var exceptThing: String
    var detailSchedule: String
    var detailScheduleTime: [String]?
    var detailScheduleContents: [String]?
    var preparation: String
    var notice: String
    var meetingPlace: String
    var isOnly: String
}
