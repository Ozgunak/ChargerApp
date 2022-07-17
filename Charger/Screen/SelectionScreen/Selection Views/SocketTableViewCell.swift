//
//  SocketTableViewCell.swift
//  Charger
//
//  Created by ozgun on 27.06.2022.
//

import UIKit

class SocketTableViewCell: UITableViewCell {

    @IBOutlet weak var timeBubbleView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()

    }
    
    var isOccupied: Bool = false {
        didSet {
            setup()
        }
    }
    var isActive: Bool = false {
        didSet {
            select()
        }
    }
    
    var selectedBorderColor = UIColor(named: "mainprimary")!.cgColor
    var unSelectedBorderColor  = UIColor(named: "charcoalGrey")!.cgColor
    var selectedBackground = UIColor(named: "dark")!
    var unSelectedBackground = UIColor(named: "charcoalGrey")!
    
    func set(model: SlotModel?) {
        timeLabel.text = model?.slot ?? ""
        isOccupied = model?.isOccupied ?? false
        isActive = model?.isActive ?? false
    }
    
    func setup() {
        self.clipsToBounds = true
        timeBubbleView.cornerRadius = 6
        timeLabel.isUserInteractionEnabled = isOccupied
        timeLabel.textColor = isOccupied ? .gray : .white
    }
    
    func select() {
        timeBubbleView.layer.borderWidth = 1
        timeBubbleView.layer.borderColor = isActive ? selectedBorderColor : unSelectedBorderColor
        timeBubbleView.backgroundColor = isActive ? selectedBackground : unSelectedBackground
    }

}
