//
//  AppointmentsTableViewCell.swift
//  Charger
//
//  Created by ozgun on 9.07.2022.
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trashImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var soketLabel: UILabel!
    @IBOutlet weak var connectionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(model: AppointmentModel) {
        nameLabel.text = model.stationName ?? ""
        let date = dateFormat(date: model.date ?? "")
        let time = model.time ?? ""
        dateLabel.text = "\(date), \(time)"
        notificationLabel.text = String(model.station?.sockets?.first?.power ?? 0)
        soketLabel.text = "Soket Numarası: \(model.socketID ?? 0)"
        connectionLabel.text = model.station?.sockets?.first?.socketType ?? ""
    }

    func dateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"
        let resultString = dateFormatter.string(from: date!)
        return resultString

    }
    
}
