//
//  RootCoordinator.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit
import MapKit

class RootCoordinator: Coordinator {
    
    // MARK: - Dependencies
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    
    private var window: UIWindow
    private var networkManager: APIRequest
        
    // MARK: - Lifecycles
    init(window: UIWindow, networkManager: APIRequest) {
        self.window = window
        self.networkManager = networkManager
    }
    
    // MARK: - Public methods
    func start() {
        let viewModel = RootViewModel(networkManager: networkManager, delegate: self)
        let viewController = RootViewController()
        viewController.viewModel = viewModel
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private methods
    private func openMapForPlace(location: CLLocationCoordinate2D, locationName: String) {
        let regionDistance: CLLocationDistance = 100
        let regionSpan = MKCoordinateRegion(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: options)
    }
    
}

// MARK: - RootViewModelDelegate
extension RootCoordinator: RootViewModelDelegate {
    func didTapStation(station: Station) {
        let viewModel = StationDetailViewModel(networkManager: networkManager, stationId: station.id, delegate: self)
        let viewController = StationDetailViewController()
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        window.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func didTapDirection(location: CLLocationCoordinate2D, locationName: String) {
        openMapForPlace(location: location, locationName: locationName)
    }
}
