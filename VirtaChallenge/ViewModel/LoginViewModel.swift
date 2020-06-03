//
//  LoginViewModel.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func loginDidSucceed()
}

class LoginViewModel {
    
    // MARK: - Observable
    var showErrorMessage: Closure<String?>?
    var isFetching: Closure<Bool>?
    
    // MARK: - Dependencies
    private weak var delegate: LoginViewModelDelegate?
    private var networkManager: APIRequest
    
    // MARK: - Lifecycles
    init(networkManager: APIRequest, delegate: LoginViewModelDelegate?) {
        self.networkManager = networkManager
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    func loginUser(with username: String?, code: String?) {
        guard let username = username, let code = code, !username.isEmpty, !code.isEmpty else {
            showErrorMessage?("Username and password cannot be empty!")
            return
        }
        
        isFetching?(true)
        
        networkManager.login(with: username, code: code, successfulCallback: { [weak self] token in
            self?.isFetching?(false)
            
            UserDefaults.standard.set(token.accessToken, forKey: AppPantry.UserPersistentKey.token)
            UserDefaults.standard.set(Date(timeIntervalSinceNow: TimeInterval(token.expiresIn)), forKey: AppPantry.UserPersistentKey.tokenExpireTime)
            UserDefaults.standard.set(true, forKey: AppPantry.UserPersistentKey.didLogin)
            
            self?.showErrorMessage?(nil)
            self?.delegate?.loginDidSucceed()
        }, errorCallback: { [weak self] error in
            self?.isFetching?(false)
            self?.showErrorMessage?(error)
        })
    }
    
}
