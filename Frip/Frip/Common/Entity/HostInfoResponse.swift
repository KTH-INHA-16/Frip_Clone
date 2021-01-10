//
//  HostInfoResponse.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation

struct HostInfoResult: Codable {
    var result: HostInfo
    var isSuccess: Bool
    var code: Int
    var message:String
}

struct HostInfo: Codable {
    var hostIdx : Int
    var hostName : String
    var hostIntroduction : String
    var hostProfileImg : String
    var hostLike : String
    var hostLikeCnt : Int
    var hostFripCnt : Int
    var hostReviewCnt : Int
}
