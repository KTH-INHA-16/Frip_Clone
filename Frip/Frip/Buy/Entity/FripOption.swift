//
//  FripOption.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation

struct Options: Codable {
    var result: [FripOption]
    var isSuccess: Bool
    var code: Int
    var message: String
}


struct FripOption: Codable {
    var fripOptionIdx: Int
    var fripOption: String
    var price: String
    var limitcount: String
    var isEnd: String
}

struct SelectOption {
    var option: FripOption 
    var count: Int
}

struct BuyResult: Codable{
    var result: BuyFripIdx
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct BuyFripIdx: Codable {
    var fripIdx: Int
}
