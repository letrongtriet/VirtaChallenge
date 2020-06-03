//
//  APIRequest.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

extension AuthAPI {
    var path: String {
        switch self {
        case .login:
            return "/auth"
        }
    }
    
    var method: RequestMethod {
        return .post
    }
    
    var headers: ReaquestHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: RequestParameters? {
        switch self {
        case let .login(email, code):
            return ["email": email,
                    "code": code]
        }
    }
}

extension StationAPI {
    var path: String {
        switch self {
        case .stations:
            return "/stations?limit=10"
            
        case let .stationDetail(id):
            return "/stations/\(id)"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var headers: ReaquestHeaders? {
        if let accessToken = UserDefaults.standard.value(forKey: AppPantry.UserPersistentKey.token) as? String {
            return ["Authorization": "Bearer \(accessToken)"]
        }
        
        return nil
    }
    
    var parameters: RequestParameters? {
        return nil
    }
}
