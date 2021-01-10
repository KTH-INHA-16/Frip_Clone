//
//  SaveHost.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation


struct SaveHostResult: Codable {
    var result : [SaveHost]
    var isSuccess : Bool
    var code : Int
    var message : String
}

struct SaveHost: Codable {
    var hostIdx: Int
    var hostName: String
    var hostProfileImg: String
    var hostLike: String
    var hostLikeCnt: Int
    var hostFripCnt: Int
    var hostReviewCnt: Int
}
