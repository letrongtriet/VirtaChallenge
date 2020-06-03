//
//  StationDetailTableViewCell.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class StationDetailTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    var evse: StationDetailEvse? {
        didSet {
            idLabel.text = " \(evse?.id ?? 0) "
        }
    }
    
    // MARK: - Private properties
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        view.addSubview(idLabel)
        
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.16, green: 0.41, blue: 0.65, alpha: 1.00)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.layer.borderColor = UIColor(red: 0.16, green: 0.41, blue: 0.65, alpha: 1.00).cgColor
        label.layer.borderWidth = 1.5
        
        return label
    }()

    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Private methods
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            idLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }

}
