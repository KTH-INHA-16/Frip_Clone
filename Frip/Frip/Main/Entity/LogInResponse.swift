//
//  LogInResponse.swift
//  Frip
//
//  Created by κΉνν on 2021/01/06.
//

import Foundation


struct LogIn: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: JWT
}

struct JWT: Codable {
    var jwt: String
}
