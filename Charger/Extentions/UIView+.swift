//
//  UIView+.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius : CGFloat{
        get { return self.cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
    func addShadowAndCornerRadius() {
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
    }
}
