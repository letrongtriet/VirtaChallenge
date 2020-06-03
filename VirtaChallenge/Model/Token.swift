//
//  Token.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

// MARK: - Token
struct Token: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case token
    }
}
