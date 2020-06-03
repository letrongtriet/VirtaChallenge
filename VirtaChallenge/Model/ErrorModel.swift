//
//  ErrorModel.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    let statusCode: Int
    let message: String
    let errorCode: Int?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message
        case errorCode = "error_code"
    }
}
