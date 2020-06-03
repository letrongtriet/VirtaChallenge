//
//  RootViewModel.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

class RootViewModel {
    
    // MARK: - Observable
    var isFetching: Closure<Bool>?
    var stations: Closure<Stations>?
    
    // MARK: - Dependencies
    private var networkManager: APIRequest
    
    // MARK: - Lifecycles
    init(networkManager: APIRequest) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public methods
    func getStations() {
        isFetching?(true)
        
        networkManager.getStationList(successfulCallback: { [weak self] stations in
            self?.stations?(stations)
            self?.isFetching?(false)
        }, errorCallback: { [weak self] error in
            print(error)
            self?.stations?([])
            self?.isFetching?(false)
        })
    }
    
}
