//
//  StationDetailViewModel.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation
import CoreLocation

class StationDetailViewModel {
    
    // MARK: - Observable
    var isFetching: Closure<Bool>?
    var stationDetail: Closure<StationDetail?>?
    
    // MARK: - Dependencies
    weak var delegate: RootViewModelDelegate?
    
    private var networkManager: APIRequest
    private var stationId: Int
    
    private var currentStationDetail: StationDetail?
        
    // MARK: - Lifecycles
    init(networkManager: APIRequest, stationId: Int, delegate: RootViewModelDelegate?) {
        self.networkManager = networkManager
        self.stationId = stationId
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    func getStationDetail() {
        isFetching?(true)
        
        networkManager.getStationDetail(with: "\(stationId)", successfulCallback: { [weak self] stationDetail in
            self?.currentStationDetail = stationDetail
            self?.stationDetail?(stationDetail)
            self?.isFetching?(false)
        }, errorCallback: { [weak self] error in
            print(error)
            self?.stationDetail?(nil)
            self?.isFetching?(false)
        })
    }
    
    func didTapDirection() {
        guard let station = currentStationDetail else { return }
        
        delegate?.didTapDirection(location: CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude), locationName: station.name)
    }
    
}
