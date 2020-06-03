//
//  LoginViewController.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Dependencies
    var viewModel: LoginViewModel!
    
    // MARK: - Private properties
    private lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.text = "Log In and Charge!"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var loginImage: UIImageView = {
        let imageView = UIImageView(image: AppPantry.AppIcon.loginIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        label.text = ""
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.setLeftView(image: AppPantry.AppIcon.personIcon)
        textField.placeholder = "Username"
        textField.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.setLeftView(image: AppPantry.AppIcon.lockIcon)
        textField.placeholder = "Password"
        textField.textColor = UIColor(red: 0.41, green:0.47, blue:0.53, alpha: 1.00)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor(red: 1.00, green: 0.97, blue: 0.00, alpha: 1.00)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00), for: .normal)
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 2.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLogin))
        button.addGestureRecognizer(tapGesture)
        
        return button
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.tintColor = .white
        view.isHidden = true
        view.stopAnimating()
        return view
    }()
    
    var activeTextField: UITextField?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameTextField.addBottomBorder()
        codeTextField.addBottomBorder()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topTitleLabel)
        view.addSubview(loginImage)
        view.addSubview(errorLabel)
        view.addSubview(usernameTextField)
        view.addSubview(codeTextField)
        view.addSubview(loginButton)
        loginButton.addSubview(loadingIndicator)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginImage.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 45),
            loginImage.heightAnchor.constraint(equalToConstant: 120),
            loginImage.widthAnchor.constraint(equalToConstant: 120),
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 25),
            usernameTextField.heightAnchor.constraint(equalToConstant: 60),
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            codeTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 5),
            codeTextField.heightAnchor.constraint(equalToConstant: 60),
            codeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            codeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalToConstant: 160),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 30),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        bindingViewModel()
    }
    
    private func bindingViewModel() {
        viewModel.showErrorMessage = { [weak self] errorMessage in
            self?.errorLabel.text = errorMessage
        }
        
        viewModel.isFetching = { [weak self] isFetching in
            self?.loadingIndicator.isHidden = !isFetching
            
            if isFetching {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func didTapLogin() {
        view.endEditing(true)
        viewModel.loginUser(with: usernameTextField.text, code: codeTextField.text)
    }
}

// MARK: - Handle keyboard
extension LoginViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if shouldMoveViewUp {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.view.frame.origin.y = 0 - keyboardSize.height
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
