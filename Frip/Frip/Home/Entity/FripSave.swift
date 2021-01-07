//
//  FripSave.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import Foundation

struct SaveResult: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
