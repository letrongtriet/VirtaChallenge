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
    var didTapDirection: Closure<Void>?
    var didTapCell: Closure<Void>?

    // MARK: - Dependencies
    var station: Station? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private properties
    private lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.16, green: 0.41, blue: 0.65, alpha: 1.00)
        label.textAlignment = .left
        
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
    
    private lazy var headerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(nil, for: .normal)
        button.setImage(nil, for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCellButton))
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
        guard let station = station else { return }
        locationNameLabel.text = station.name
        addressLabel.text = station.address
        
        if let currentUserLocation = CLLocationManager().location {
            let location = CLLocation(latitude: station.latitude, longitude: station.longitude)
            let distance = location.distance(from: currentUserLocation)
            
            if distance > 1000 {
                distanceLabel.text = "\(Int(distance/1000)) km"
            } else {
                distanceLabel.text = "\(Int(distance)) m"
            }
        }
    }
    
    // MARK: - Private methods
    private func setup() {
        backgroundColor = .white
        
        addSubview(locationNameLabel)
        addSubview(addressLabel)
        addSubview(distanceLabel)
        addSubview(headerButton)
        addSubview(directionButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            headerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: locationNameLabel.centerYAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: directionButton.leadingAnchor, constant: -11),
            distanceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: locationNameLabel.trailingAnchor, constant: 5)
        ])
        
        bringSubviewToFront(directionButton)
    }
    
    @objc private func didTapDirectionButton() {
        didTapDirection?(())
    }
    
    @objc private func didTapCellButton() {
        didTapCell?(())
    }
    
}
