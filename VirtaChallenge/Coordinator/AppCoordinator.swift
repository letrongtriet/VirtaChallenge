//
//  AppCoordinator.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit
import CoreLocation

class AppCoordinator: Coordinator {
    
    // MARK: - Dependencies
    private var loginCoordinator: LoginCoordinator?
    private var rootCoordinator: RootCoordinator?
    private var window: UIWindow
    
    private var networkManager: APIRequest
    
    private var locationManager: CLLocationManager
    
    init(window: UIWindow) {
        self.window = window
        self.networkManager = APIRequest()
        self.locationManager = CLLocationManager()
    }
    
    func start() {
        requestForLocationService()
        
        window.overrideUserInterfaceStyle = .light
        
        if UserDefaults.standard.bool(forKey: AppPantry.UserPersistentKey.didLogin),
            let tokenExpireTime = UserDefaults.standard.value(forKey: AppPantry.UserPersistentKey.tokenExpireTime) as? Date,
            tokenExpireTime > Date() {
            print("Token is still fresh!")
            showRoot()
        } else {
            showLogin()
        }
    }
    
    private func requestForLocationService() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
}

// MARK: - Login
extension AppCoordinator: LoginCoordinatorDelegate {
    
    private func showLogin() {
        loginCoordinator = LoginCoordinator(window: window, networkManager: networkManager, delegate: self)
        loginCoordinator?.start()
    }
    
    func loginCoordinatorDidFinish() {
        loginCoordinator = nil
        showRoot()
    }
    
}

// MARK: - Root
extension AppCoordinator {
    
    private func showRoot() {
        rootCoordinator = RootCoordinator(window: window, networkManager: networkManager)
        rootCoordinator?.start()
    }
    
}
