//
//  CommentEntity.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import Foundation

struct CommentResults:Codable {
    var result: [Comment]
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct Comment: Codable {
    var fripFeedCommentIdx: Int
    var fripFeedComment: String
    var fripFeedCommentTime: String
    var isUser: String
    var userIdx: Int
    var userProfileImg: String
    var userNickname: String
}

struct CommentMessage: Codable {
    var message: String
}
