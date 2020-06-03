//
//  RootViewController.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Dependencies
    var viewModel: RootViewModel!
    
    // MARK: - Private properties
    private lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        label.text = "Nearby"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.41, green: 0.47, blue: 0.53, alpha: 1.00)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.width
        let minimumInteritemSpacing: CGFloat = 10
        let edgeInset: CGFloat = 16 * 2
        let marginsAndInsets = edgeInset + (minimumInteritemSpacing * CGFloat(3 - 1))
        let itemWidth = ((width - marginsAndInsets) / CGFloat(3)).rounded(.down)
        let itemHeight = itemWidth * 44 / 86
        
        let cellSize = CGSize(width: itemWidth , height: itemHeight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 5, right: 16)
        layout.minimumLineSpacing = minimumInteritemSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 55)
        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 4)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(StationCollectionViewCell.self, forCellWithReuseIdentifier: "StationCollectionViewCell")
        collectionView.register(StationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StationHeaderView")
        collectionView.register(StationFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "StationFooterView")
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.refreshControl = refreshControl
                
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .black
        return refreshControl
    }()
    
    private var stations: Stations = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00)
        
        view.addSubview(topTitleLabel)
        view.addSubview(dividerView)
        view.addSubview(collectionView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 5),
            dividerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        bindingViewModel()
    }
    
    private func bindingViewModel() {
        viewModel.isFetching = { [weak self] isFetching in
            self?.handleState(isFetching)
        }
        
        viewModel.stations = { [weak self] stations in
            self?.stations = stations
        }
        
        refresh()
    }
    
    private func handleState(_ isFetching: Bool) {
        if isFetching {
            guard !refreshControl.isRefreshing else { return }
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
            collectionView.reloadData()
        }
    }
    
    @objc private func refresh() {
        viewModel.getStations()
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stations[section].evses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationCollectionViewCell", for: indexPath) as? StationCollectionViewCell else { return UICollectionViewCell() }
        
        cell.evse = stations[indexPath.section].evses[indexPath.row]
        cell.updateUI()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StationHeaderView", for: indexPath) as? StationHeaderView else { return UICollectionReusableView() }
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "StationFooterView", for: indexPath) as? StationFooterView else { return UICollectionReusableView() }
        
        if kind == UICollectionView.elementKindSectionHeader {
            headerView.station = stations[indexPath.section]
            headerView.updateUI()

            return headerView
        }
        
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = StationDetailViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
    
}
