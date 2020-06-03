//
//  APIRequest.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

typealias ReaquestHeaders = [String: String]
typealias RequestParameters = [String : Any?]
typealias Closure<T> = (T) -> Void

protocol APIRequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: ReaquestHeaders? { get }
    var parameters: RequestParameters? { get }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum AuthAPI: APIRequestProtocol {
    case login(email: String, code: String)
}

public enum StationAPI: APIRequestProtocol {
    case stations
    case stationDetail(id: String)
}
