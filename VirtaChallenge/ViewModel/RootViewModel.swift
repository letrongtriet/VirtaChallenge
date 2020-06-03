//
//  RootViewModel.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation
import CoreLocation

protocol RootViewModelDelegate: class {
    func didTapStation(station: Station)
    func didTapDirection(location: CLLocationCoordinate2D, locationName: String)
}

class RootViewModel {
    
    // MARK: - Observable
    var isFetching: Closure<Bool>?
    var stations: Closure<Stations>?
    
    // MARK: - Dependencies
    weak var delegate: RootViewModelDelegate?
    
    private var networkManager: APIRequest
    private var currentStations = Stations()
        
    // MARK: - Lifecycles
    init(networkManager: APIRequest, delegate: RootViewModelDelegate?) {
        self.networkManager = networkManager
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    func getStations() {
        isFetching?(true)
        
        networkManager.getStationList(successfulCallback: { [weak self] stations in
            self?.didGetNewStations(stations)
        }, errorCallback: { [weak self] error in
            print(error)
            self?.currentStations = []
            self?.stations?([])
            self?.isFetching?(false)
        })
    }
    
    func didTapCell(at indexPath: IndexPath) {
        let station = currentStations[indexPath.section]
        delegate?.didTapStation(station: station)
    }
    
    func didTapDirection(location: CLLocationCoordinate2D, locationName: String) {
        delegate?.didTapDirection(location: location, locationName: locationName)
    }
    
    // MARK - Private methods
    private func didGetNewStations(_ stations: Stations) {
        currentStations = stations
        
        if let currentUserLocation = CLLocationManager().location {
            currentStations = currentStations.sorted(by: { (station1, station2) -> Bool in
                let location1 = CLLocation(latitude: station1.latitude, longitude: station1.longitude)
                let location2 = CLLocation(latitude: station2.latitude, longitude: station2.longitude)
                let distance1 = location1.distance(from: currentUserLocation)
                let distance2 = location2.distance(from: currentUserLocation)
                
                return distance1 < distance2
            })
        }
        
        self.stations?(currentStations)
        isFetching?(false)
    }
    
}
