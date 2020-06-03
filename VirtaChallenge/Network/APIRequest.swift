//
//  APIRequest.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

public final class APIRequest {
    func login(with username: String, code: String, successfulCallback: Closure<Token>?, errorCallback: Closure<String>?) {
        makeRequest(requestType: AuthAPI.login(email: username, code: code), successfulCallback: successfulCallback, errorCallback: errorCallback)
    }
    
    func getStationList(successfulCallback: Closure<Stations>?, errorCallback: Closure<String>?) {
        makeRequest(requestType: StationAPI.stations, successfulCallback: successfulCallback, errorCallback: errorCallback)
    }
    
    func getStationDetail(with id: String, successfulCallback: Closure<StationDetail>?, errorCallback: Closure<String>?) {
        makeRequest(requestType: StationAPI.stationDetail(id: id), successfulCallback: successfulCallback, errorCallback: errorCallback)
    }
}

extension APIRequest {
    private func makeRequest<T: Codable>(requestType: APIRequestProtocol, successfulCallback: Closure<T>?, errorCallback: Closure<String>?) {
        let urlString = AppPantry.Network.baseUrl + requestType.path
        
        guard let url = URL(string: urlString) else {
            runOnMainThread {
                errorCallback?("Something went wrong!")
            }
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: 60)
        
        if let parameters = requestType.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        if let headers = requestType.headers {
            request.allHTTPHeaderFields = headers
        }
        
        request.httpMethod = requestType.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                runOnMainThread {
                    errorCallback?(error.localizedDescription)
                }
            } else if let data = data {
                if let value = try? JSONDecoder().decode(T.self, from: data) {
                    runOnMainThread {
                        successfulCallback?(value)
                    }
                } else if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    runOnMainThread {
                        errorCallback?(errorModel.message)
                    }
                } else {
                    runOnMainThread {
                        errorCallback?("Something went wrong!")
                    }
                }
            }
        }
        task.resume()
    }
}
