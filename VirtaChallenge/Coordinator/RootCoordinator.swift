//
//  RootCoordinator.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

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
        let viewModel = RootViewModel(networkManager: networkManager)
        let viewController = RootViewController()
        viewController.viewModel = viewModel
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
