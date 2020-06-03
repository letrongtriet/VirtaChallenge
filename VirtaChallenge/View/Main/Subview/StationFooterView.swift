//
//  StationFooterView.swift
//  VirtaChallenge
//
//  Created by Triet Le on 3.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class StationFooterView: UICollectionReusableView {
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Private methods
    private func setup() {
        backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00)
    }
}
