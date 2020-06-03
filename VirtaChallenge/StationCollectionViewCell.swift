//
//  StationCollectionViewCell.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class StationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies
    var evse: Evse?
    
    // MARK: - Private properties
    private lazy var connectorIcon: UIImageView = {
        let view = UIImageView(image: AppPantry.AppIcon.type2Icon)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var numberOfConnectorLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        label.text = "x2"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var powerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.text = "22"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var powerUnit: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        label.text = "kW"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        
        stackView.addArrangedSubview(connectorIcon)
        stackView.addArrangedSubview(numberOfConnectorLabel)
        
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        
        stackView.addArrangedSubview(powerLabel)
        stackView.addArrangedSubview(powerUnit)
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(rightStackView)
        
        return stackView
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
        guard let evse = evse else { return }
        
        powerLabel.text = "\(Int(evse.connectors.first?.maxKw ?? 0))"
        
        if evse.connectors.count > 1 {
            numberOfConnectorLabel.text = "x\(evse.connectors.count)"
        } else {
            numberOfConnectorLabel.text = nil
        }
    }
    
    // MARK: - Private methods
    private func setup() {
        backgroundColor = .white
        addSubview(mainStackView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
}
