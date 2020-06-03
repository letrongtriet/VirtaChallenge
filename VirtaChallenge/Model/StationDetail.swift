//
//  StationDetail.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

// MARK: - StationDetail
struct StationDetail: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let icon: Int
    let address, city: String
    let openHours: String
    let providers: String
    let pictures: [String]
    let isV2G: Bool
    let eichrechtType: String
    let termsAndConditionsURLActingEmp: String?
    let termsLink: String?
    let evses: [StationDetailEvse]

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, icon, address, city, openHours, providers, pictures, isV2G, eichrechtType
        case termsAndConditionsURLActingEmp = "termsAndConditionsUrlActingEmp"
        case termsLink, evses
    }
}

// MARK: - StationDetailEvse
struct StationDetailEvse: Codable {
    let id: Int
    let connectors: [StationDetailConnector]
    let available, reservable, reserved, occupied: Bool
    let isV2G: Bool
    let currency: String
    let pricing: [StationDetailPricing]
    let oneTimePayment, oneTimePaymentInAppEnabled: Bool
    let status, oneTimeMinimum: Int
    let oneTimePricing: [StationDetailPricing]
    let oneTimePricingRatio: Double
    let minutesWithoutTimeCharge: Int
    let isFree: Bool
    let evseID: String

    enum CodingKeys: String, CodingKey {
        case id, connectors, available, reservable, reserved, occupied, isV2G, currency, pricing, oneTimePayment, oneTimePaymentInAppEnabled, status, oneTimeMinimum, oneTimePricing, oneTimePricingRatio, minutesWithoutTimeCharge, isFree
        case evseID = "evseId"
    }
}

// MARK: - StationDetailConnector
struct StationDetailConnector: Codable {
    let connectorID: Int
    let type: String
    let maxKwh, maxKw: Double
    let currentType: String
    let status: String?
}

// MARK: - Pricing
struct StationDetailPricing: Codable {
    let name: String
    let priceCents: Int
    let currency: String
    let priceCentsWithoutVat, priceCentsVat: Double
}
