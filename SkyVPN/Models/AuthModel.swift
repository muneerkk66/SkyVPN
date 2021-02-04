//
//  User.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation

struct LoginResponse: Codable {
    var data: TokenResponse
}

struct TokenResponse: Codable {
    var token: String

    // MARK: Codingkey Swift will automatically use this as the key type. This therefore allows you to easily customise the keys that your properties are encoded/decoded with.

    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}

struct SignUpResponse: Codable {
    var email: String
    var password: String
}
