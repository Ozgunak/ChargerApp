//
//  Color.swift
//  Charger
//
//  Created by ozgun on 2.07.2022.
//

import UIKit

class Colors {
    var gl: CAGradientLayer!

    init() {
        let colorTop = UIColor(red: 64.0 / 255.0, green: 69.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 22.0 / 255.0, green: 24.0 / 255.0, blue: 29.0 / 255.0, alpha: 1.0).cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
