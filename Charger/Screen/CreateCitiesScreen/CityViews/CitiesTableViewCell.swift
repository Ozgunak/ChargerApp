//
//  CitiesTableViewCell.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ name: String) {
        cityLabel.text = name
    }
    
}
