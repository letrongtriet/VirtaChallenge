//
//  UITextField+Extension.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.74, green: 0.73, blue: 0.76, alpha: 1.00).cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    func setLeftView(image: UIImage?) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
