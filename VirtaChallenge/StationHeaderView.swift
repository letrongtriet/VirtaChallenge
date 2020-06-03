//
//  StationHeaderView.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit
import CoreLocation

class StationHeaderView: UICollectionReusableView {
    
    // MARK: - Observable
    var didTapDirection: Closure<CLLocationCoordinate2D>?

    // MARK: - Dependencies
    var station: Station?
    
    // MARK: - Private properties
    private lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Location Name"
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Address"
        
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.16, green: 0.41, blue: 0.65, alpha: 1.00)
        label.textAlignment = .left
        label.text = "800 m"
        
        return label
    }()
    
    private lazy var directionButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(nil, for: .normal)
        button.setImage(AppPantry.AppIcon.navigateIcon, for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDirectionButton))
        button.addGestureRecognizer(tapGesture)
        
        return button
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Public methods
    func updateUI() {
        locationNameLabel.text = station?.name
        addressLabel.text = station?.address
    }
    
    // MARK: - Private methods
    private func setup() {
        backgroundColor = .white
        
        addSubview(locationNameLabel)
        addSubview(addressLabel)
        addSubview(distanceLabel)
        addSubview(directionButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            locationNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 3),
            addressLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            directionButton.centerYAnchor.constraint(equalTo: locationNameLabel.centerYAnchor),
            directionButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            directionButton.heightAnchor.constraint(equalToConstant: 25),
            directionButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: locationNameLabel.centerYAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: directionButton.leadingAnchor, constant: -11),
            distanceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: locationNameLabel.trailingAnchor, constant: 5)
        ])
    }
    
    @objc private func didTapDirectionButton() {
        print("didTapDirection")
    }
    
}
