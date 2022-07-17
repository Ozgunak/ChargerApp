//
//  FiltersCollectionViewCell.swift
//  Charger
//
//  Created by ozgun on 26.06.2022.
//

import UIKit

class FiltersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        
        bubbleView.layer.cornerRadius = bubbleView.bounds.height / 2
        bubbleView.layer.borderWidth = 2
        bubbleView.layer.borderColor = UIColor.green.cgColor
    }
    
    func setup(text: String) {
        let rawText = "\(text) | "
        textLabel.text = rawText
    }
}
