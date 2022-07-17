//
//  FilterButton.swift
//  Charger
//
//  Created by ozgun on 26.06.2022.
//

import UIKit

@IBDesignable class FilterButton: UIButton {
    var active: Bool = false {
        didSet {
            setup()
        }
    }
    var borderWidth: CGFloat = 2.0
    var selectedBorderColor = UIColor.green.cgColor
    var unSelectedBorderColor  = UIColor.gray.cgColor
    var selectedBackground: UIColor = .black
    var unSelectedBackground: UIColor = .clear
    

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.layer.borderColor = active ? selectedBorderColor : unSelectedBorderColor
        self.backgroundColor = active ? selectedBackground : unSelectedBackground
        self.layer.borderWidth = borderWidth
    }
}
