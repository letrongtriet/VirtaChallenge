//
//  Station.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

// MARK: - Station
struct Station: Codable {
    let id: Int
    let latitude, longitude: Double
    let icon: Int
    let name, city, address: String
    let provider: String
    let evses: [Evse]
    let isRemoved, isPrivate: Bool
}

// MARK: - Evse
struct Evse: Codable {
    let id: Int
    let groupName: String
    let connectors: [Connector]
}

// MARK: - Connector
struct Connector: Codable {
    let type: String
    let maxKw: Double
}

typealias Stations = [Station]
