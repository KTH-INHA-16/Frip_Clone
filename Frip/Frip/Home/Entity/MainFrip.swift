//
//  GetMainFrip.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import Foundation

struct HomeFrips: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [Frip]
}

struct Frip: Codable {
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
}
