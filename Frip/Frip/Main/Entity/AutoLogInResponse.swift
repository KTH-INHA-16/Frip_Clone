//
//  AutoLogInResponse.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/06.
//

import Foundation

struct AutoLogin: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
