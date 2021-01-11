//
//  CommentPostEntity.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/12.
//

import Foundation

struct CommentPost:Codable {
    var result: CommentPostResult
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct CommentPostResult: Codable {
    var fripReviewIdx: Int
}
