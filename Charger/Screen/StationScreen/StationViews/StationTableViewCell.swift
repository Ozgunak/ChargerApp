//
//  StationTableViewCell.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var socketLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ACDCimageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ model: StationModel) {
        let socketText = String( "\(model.socketCount ?? 0) / 3")
        socketLabel.text = socketText
        let distance = String(format: "%.1f km", model.distanceInKM ?? 0)
        distanceLabel.text = distance
        locationLabel.text = model.stationName ?? "yok"
        model.sockets?.forEach({ socket in
            if let type = socket.chargeType {
                if type.contains("AC") || type.contains("DC")  {
                    ACDCimageView.image = UIImage(named: "ACDC")
                } else if type.contains("DC") {
                    ACDCimageView.image = UIImage(named: "DC")
                } else if type.contains("AC"){
                    ACDCimageView.image = UIImage(named: "AC")
                }
            }
        })
 
    }
    
}


