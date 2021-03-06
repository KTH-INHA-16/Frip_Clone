//
//  CommentPostEntity.swift
//  Frip
//
//  Created by κΉνν on 2021/01/12.
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
