//
//  RezDetailViewController.swift
//  Charger
//
//  Created by ozgun on 30.06.2022.
//

import UIKit

class RezDetailViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stationCode: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    
    @IBOutlet weak var chargeTypeLabel: UILabel!
    @IBOutlet weak var socketNumberLabel: UILabel!
    @IBOutlet weak var socketTypeLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var interactor: RezDetailInteractor?
    var router: Routable?
    var model: SelectionModel?
    var selectedSocket: SocketSelectionModel?
    var distance: Double?
    var isoDate: String?
    var selectedHour: String?
    var selectedDay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        set(with: model!)
        setup()
    }
    
    func setup() {
        let viewController = self
        let interactor = RezDetailInteractor()
        let router = Router()
        viewController.interactor = interactor
        viewController.router = router
    }

    func set(with model: SelectionModel) {
        adressLabel.text = model.geoLocation?.address ?? ""
        distanceLabel.text = String(format: "%.1f" ,distance ?? 0)
        stationCode.text = model.stationCode ?? ""
        servicesLabel.text = model.services?.description
        socketNumberLabel.text = String(selectedSocket?.socketNumber ?? 0)
        chargeTypeLabel.text = selectedSocket?.chargeType ?? ""
        socketTypeLabel.text = selectedSocket?.socketType ?? ""
        powerLabel.text = String("\(selectedSocket?.power ?? 0) \(selectedSocket?.powerUnit ?? "")")
        dateLabel.text = selectedDay ?? ""
        hourLabel.text = selectedHour ?? ""
    }
    @IBAction func approvePressed(_ sender: UIButton) {
        interactor?.getRezervation(station: model?.stationID ?? 0,
                                   socketID: selectedSocket?.socketID ?? 0,
                                   timeSlot: selectedHour ?? "",
                                   appointmentDate: selectedSocket?.day?.date ?? "",
                                   completion: { result in
            switch result {
            case true:
                DispatchQueue.main.async {
                    self.router?.routeToMain(from: self.navigationController!)
                }
            case false:
        
                return
            }
        })
    }
    
}

