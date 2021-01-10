//
//  SaveFrip.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import Foundation

struct SaveFripResult: Codable {
    var result: [SaveFrip]
    var isSuccess : Bool
    var code : Int
    var message : String
    
}

struct SaveFrip: Codable {
    var fripIdx : Int
    var fripHeader :String
    var fripTitle :String
    var price :String
    var rate :String
    var isNew :String
    var isOnly :String
    var place :String
    var fripLike :String
    var fripPhotoUrl :String
}
