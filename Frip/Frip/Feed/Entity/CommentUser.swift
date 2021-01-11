//
//  CommentUser.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/11.
//

import Foundation

struct CommentMyResult: Codable {
    var result: MyInfo
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct MyInfo: Codable {
    var userIdx : Int
    var userNickname : String
    var profileImg : String
    var reviewCnt : Int
    var feedCnt : Int
}
