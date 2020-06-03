//
//  LoginCoordinator.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit
import CoreLocation

protocol LoginCoordinatorDelegate: class {
    func loginCoordinatorDidFinish()
}

class LoginCoordinator: Coordinator {
    
    // MARK: - Dependencies
    weak var delegate: LoginCoordinatorDelegate?
    
    private var window: UIWindow
    private var networkManager: APIRequest
    
    // MARK: - Lifecycles
    init(window: UIWindow, networkManager: APIRequest, delegate: LoginCoordinatorDelegate?) {
        self.window = window
        self.networkManager = networkManager
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    func start() {
        let viewModel = LoginViewModel(networkManager: networkManager, delegate: self)
        let viewController = LoginViewController()
        viewController.viewModel = viewModel
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
}

extension LoginCoordinator: LoginViewModelDelegate {
    func loginDidSucceed() {
        delegate?.loginCoordinatorDidFinish()
    }
}
