//
//  StationDetailViewModel.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

class StationDetailViewModel {
    
    // MARK: - Observable
    var isFetching: Closure<Bool>?
    var stationDetail: Closure<StationDetail>?
    
    // MARK: - Dependencies
    private var networkManager: APIRequest
    private var stationId: Int
    
    // MARK: - Lifecycles
    init(networkManager: APIRequest, stationId: Int) {
        self.networkManager = networkManager
        self.stationId = stationId
    }
    
    // MARK: - Public methods
    func getStationDetail() {
        isFetching?(true)
        
        networkManager.getStationDetail(with: "\(stationId)", successfulCallback: { [weak self] stationDetail in
            self?.stationDetail?(stationDetail)
            self?.isFetching?(false)
        }, errorCallback: { [weak self] error in
            print(error)
            self?.isFetching?(false)
        })
    }
    
}
