//
//  StationDetailViewController.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit
import CoreLocation

class StationDetailViewController: UIViewController {
    
    // MARK: - Dependencies
    var viewModel: StationDetailViewModel!
    
    // MARK: - Private properties
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        view.addSubview(locationNameLabel)
        view.addSubview(addressLabel)
        view.addSubview(distanceLabel)
        view.addSubview(directionButton)
        view.addSubview(closeButton)
        view.addSubview(dividerView)
        
        view.addSubview(tableView)
        
        view.addSubview(infoAndHelpLabel)
        view.addSubview(virtaLabel)
        view.addSubview(providerLabel)
        
        view.addSubview(infoImage)
        view.addSubview(reportImage)
        view.addSubview(rightArrow)
        view.addSubview(secondRightArrow)
        view.addSubview(howToUseStackView)
        view.addSubview(reportStackView)
        
        return view
    }()
    
    private lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        
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
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(nil, for: .normal)
        button.setImage(AppPantry.AppIcon.closeIcon, for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        button.addGestureRecognizer(tapGesture)
        
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(StationDetailTableViewCell.self, forCellReuseIdentifier: "StationDetailTableViewCell")
        
        return tableView
    }()
    
    private lazy var infoAndHelpLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Info and Help"
        
        return label
    }()
    
    private lazy var virtaLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Virta"
        
        return label
    }()
    
    private lazy var providerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Provider"
        
        return label
    }()
    
    private lazy var infoImage: UIImageView = {
        let imageView = UIImageView(image: AppPantry.AppIcon.infoIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var reportImage: UIImageView = {
        let imageView = UIImageView(image: AppPantry.AppIcon.sadFeedbackIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rightArrow: UIImageView = {
        let imageView = UIImageView(image: AppPantry.AppIcon.rightArrowIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var secondRightArrow: UIImageView = {
        let imageView = UIImageView(image: AppPantry.AppIcon.rightArrowIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var howToUseLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        label.text = "How to Use"
        
        return label
    }()
    
    private lazy var reportLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.10, green: 0.20, blue: 0.29, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Report Issue"
        
        return label
    }()
    
    private lazy var howToUseInstruction: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        label.textAlignment = .left
        label.text = "We are always here to help"
        
        return label
    }()
    
    private lazy var reportInstruction: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        label.textAlignment = .left
        label.text = "Something not perfect?"
        
        return label
    }()
    
    private lazy var howToUseStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(howToUseLabel)
        stackView.addArrangedSubview(howToUseInstruction)
        
        return stackView
    }()
    
    private lazy var reportStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(reportLabel)
        stackView.addArrangedSubview(reportInstruction)
        
        return stackView
    }()
    
    private var station: StationDetail?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Private methods
    private func setup() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        view.addGestureRecognizer(tap)
        
        view.addSubview(containerView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        infoAndHelpLabel.translatesAutoresizingMaskIntoConstraints = false
        virtaLabel.translatesAutoresizingMaskIntoConstraints = false
        providerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        reportImage.translatesAutoresizingMaskIntoConstraints = false
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        secondRightArrow.translatesAutoresizingMaskIntoConstraints = false
        howToUseStackView.translatesAutoresizingMaskIntoConstraints = false
        reportStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            closeButton.heightAnchor.constraint(equalToConstant: 45),
            closeButton.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            locationNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            locationNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: closeButton.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 3),
            addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(greaterThanOrEqualTo: closeButton.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            directionButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            directionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            directionButton.heightAnchor.constraint(equalToConstant: 35),
            directionButton.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: directionButton.centerYAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: directionButton.leadingAnchor, constant: -11)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: directionButton.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            reportStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            reportStackView.trailingAnchor.constraint(equalTo: secondRightArrow.leadingAnchor, constant: -5),
            reportStackView.leadingAnchor.constraint(equalTo: reportImage.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            secondRightArrow.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            secondRightArrow.centerYAnchor.constraint(equalTo: reportStackView.centerYAnchor),
            secondRightArrow.widthAnchor.constraint(equalToConstant: 25),
            secondRightArrow.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            howToUseStackView.bottomAnchor.constraint(equalTo: reportStackView.topAnchor, constant: -10),
            howToUseStackView.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            howToUseStackView.leadingAnchor.constraint(equalTo: infoImage.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            rightArrow.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            rightArrow.centerYAnchor.constraint(equalTo: howToUseStackView.centerYAnchor),
            rightArrow.widthAnchor.constraint(equalToConstant: 25),
            rightArrow.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            infoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            infoImage.centerYAnchor.constraint(equalTo: howToUseStackView.centerYAnchor),
            infoImage.widthAnchor.constraint(equalToConstant: 25),
            infoImage.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            reportImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            reportImage.centerYAnchor.constraint(equalTo: reportStackView.centerYAnchor),
            reportImage.widthAnchor.constraint(equalToConstant: 25),
            reportImage.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            infoAndHelpLabel.bottomAnchor.constraint(equalTo: virtaLabel.topAnchor, constant: -15),
            infoAndHelpLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            virtaLabel.bottomAnchor.constraint(equalTo: providerLabel.topAnchor, constant: -3),
            virtaLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            providerLabel.bottomAnchor.constraint(equalTo: howToUseStackView.topAnchor, constant: -20),
            providerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: infoAndHelpLabel.topAnchor, constant: -15),
            tableView.topAnchor.constraint(equalTo: dividerView.bottomAnchor)
        ])
        
        bindingViewModel()
    }
    
    private func bindingViewModel() {
        viewModel.stationDetail = { [weak self] station in
            self?.station = station
            self?.updateUI()
        }
        
        viewModel.getStationDetail()
    }
    
    private func updateUI() {
        guard let station = station else { return }
        
        locationNameLabel.text = station.name
        addressLabel.text = station.address
        tableView.reloadData()
        
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
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDirectionButton() {
        viewModel.didTapDirection()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension StationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return station?.evses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let station = station else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StationDetailTableViewCell", for: indexPath) as? StationDetailTableViewCell else { return UITableViewCell() }
        
        cell.evse = station.evses[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 35))
        
        let frame = CGRect(x: 16, y: 15, width: tableView.bounds.width, height: 18)
        let label = UILabel(frame: frame)
        
        label.text = "Pick a charging point"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
