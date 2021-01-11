//
//  FeedEntity.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import Foundation

struct FeedResult: Codable {
    var result: [Feed]
    var isSuccess: Bool
    var code: Int
}

struct Feed: Codable {
    var feedIdx: Int
    var userIdx: Int
    var userProfileImg: String
    var userNickname: String
    var feedTime: String
    var isUser: String
    var feedPhoto: String
    var feed: String
    var feedLike: String
    var feedLikeCnt: Int
    var feedCommentCnt: Int
    var fripIdx: Int
    var fripTitle: String
}
