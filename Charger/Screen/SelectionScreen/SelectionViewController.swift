//
//  SelectionViewController.swift
//  Charger
//
//  Created by ozgun on 27.06.2022.
//

import UIKit

class SelectionViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var socketThreeTableView: UITableView!
    @IBOutlet weak var socketTwoTableView: UITableView!
    @IBOutlet weak var socketOneTableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var soket3StackView: UIStackView!
    @IBOutlet weak var soket2StackView: UIStackView!
    @IBOutlet weak var soket1StackView: UIStackView!
    @IBOutlet weak var soket3PowerLabel: UILabel!
    @IBOutlet weak var soket2PowerLabel: UILabel!
    @IBOutlet weak var soket1PowerLabel: UILabel!
    
    var interactor: SelectionLogic?
    var router: Routable?
    var date: String?
    var selectedStation: StationModel?
    var selectedSocket: SocketSelectionModel?
    var selectedHour: String?
    var selectedDay: String?
    var model: SelectionModel?
    var soket1Array: [SlotModel]?
    var soket2Array: [SlotModel]?
    var soket3Array: [SlotModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SocketTableViewCell", bundle: nil)
        socketOneTableView.register(nib, forCellReuseIdentifier: "SocketTableViewCell")
        socketTwoTableView.register(nib, forCellReuseIdentifier: "SocketTableViewCell")
        socketThreeTableView.register(nib, forCellReuseIdentifier: "SocketTableViewCell")
        setup()
        interactor?.getSelection(station: selectedStation?.id ?? 0, date: date ?? Date().toISOString(), completion: { model in
            if let model = model {
                self.model = model
                switch model.sockets?.count {
                case 1:
                    self.soket1Array = model.sockets?[0].day?.timeSlots
                    break
                case 2:
                    self.soket1Array = model.sockets?[0].day?.timeSlots
                    self.soket2Array = model.sockets?[1].day?.timeSlots
                    break
                default:
                    self.soket1Array = model.sockets?[0].day?.timeSlots
                    self.soket2Array = model.sockets?[1].day?.timeSlots
                    self.soket3Array = model.sockets?[1].day?.timeSlots
                    break
                }
                DispatchQueue.main.async {
                    self.setupStation()
                }
            }
            self.reloadTableview()
        })
    }
    
    func setup() {
        let viewController = self
        let interactor = SelectionInteractor()
        let router = Router()
        viewController.interactor = interactor
        viewController.router = router
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        navigationItem.setTitle("Tarih ve Saat Seçin", subtitle: model?.stationName ?? "")
        createDatePicker()
        dateTextField.text = Date().toString()
        continueButton.isUserInteractionEnabled = false
    }
    
    func setupStation() {
        if let sockets = model?.sockets {
            switch sockets.count {
            case 2:
                soket1PowerLabel.text = setText(text1: sockets[0].powerUnit ?? "",
                                                text2: sockets[0].socketType ?? "")
                soket2PowerLabel.text = setText(text1: sockets[1].chargeType ?? "",
                                                text2: sockets[1].socketType ?? "")
                soket3StackView.isHidden = true
                break
            case 1:
                soket1PowerLabel.text = setText(text1: sockets.first?.chargeType ?? "",
                                                text2: sockets.first?.socketType ?? "")
                soket3StackView.isHidden = true
                soket2StackView.isHidden = true
                break
            default:
                soket1PowerLabel.text = setText(text1: sockets.first?.chargeType ?? "",
                                                text2: sockets.first?.socketType ?? "")
                soket2PowerLabel.text = setText(text1: sockets[1].chargeType ?? "",
                                                text2: sockets[1].socketType ?? "")
                soket3PowerLabel.text = setText(text1: sockets[2].chargeType ?? "",
                                                text2: sockets[2].socketType ?? "")
                break
            }
        }
    }
    
    func setText(text1: String, text2: String) -> String {
        return "\(text1) * \(text2)"
    }
    func createDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        let maxDate = "2023-12-31 23:59"
        datePicker.maximumDate = maxDate.toDate()
        datePicker.minimumDate = Date()
        dateTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
    }
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
    @objc func dateChanged(datePicker: UIDatePicker) {
        dateTextField.text =  datePicker.date.toString()
        selectedDay = datePicker.date.toString()
        clearTableview()
        date = datePicker.date.toISOString()
        interactor?.getSelection(station: selectedStation?.id ?? 0, date: date!, completion: { model in
            self.model = model
            self.reloadTableview()
        })
    }
    
    func reloadTableview() {
        DispatchQueue.main.async {
            self.socketOneTableView.reloadData()
            self.socketTwoTableView.reloadData()
            self.socketThreeTableView.reloadData()
        }
    }
    
    func clearTableview() {
        soket1Array?.indices.forEach { soket1Array?[$0].isActive = false }
        soket2Array?.indices.forEach { soket2Array?[$0].isActive = false }
        soket3Array?.indices.forEach { soket3Array?[$0].isActive = false }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        if selectedSocket != nil {
            let sb: UIStoryboard = UIStoryboard(name: "RezDetail", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RezDetailViewController") as! RezDetailViewController
            vc.model = model
            vc.distance = selectedStation?.distanceInKM
            vc.selectedSocket = selectedSocket
            vc.isoDate = date ?? Date().toISOString()
            vc.selectedHour = selectedHour
            vc.selectedDay = selectedDay
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            continueButton.isUserInteractionEnabled = false
        }
    }
}

//MARK: - TableView Delegate and Data Source Methods

extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case socketOneTableView: return soket1Array?.count ?? 0
        case socketTwoTableView: return soket2Array?.count ?? 0
        case socketThreeTableView: return soket3Array?.count ?? 0
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case socketOneTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocketTableViewCell", for: indexPath) as! SocketTableViewCell
            cell.set(model: soket1Array?[indexPath.row])
            return cell
        case socketTwoTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocketTableViewCell", for: indexPath) as! SocketTableViewCell
            cell.set(model: soket2Array?[indexPath.row])
            return cell
        case socketThreeTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocketTableViewCell", for: indexPath) as! SocketTableViewCell
            cell.set(model: soket3Array?[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clearTableview()
        switch tableView {
        case socketOneTableView:
            if soket1Array?[indexPath.row].isOccupied == false {
                soket1Array?[indexPath.row].isActive = true
                selectedSocket = model?.sockets?[0]
                selectedHour = soket1Array?[indexPath.row].slot
            }
        case socketTwoTableView:
            if soket2Array?[indexPath.row].isOccupied == false {
                soket2Array?[indexPath.row].isActive = true
                selectedSocket = model?.sockets?[1]
                selectedHour = soket2Array?[indexPath.row].slot
            }
        case socketThreeTableView:
            if soket3Array?[indexPath.row].isOccupied == false {
                soket3Array?[indexPath.row].isActive = true
                selectedSocket = model?.sockets?[2]
                selectedHour = soket3Array?[indexPath.row].slot
            }
        default: break
        }
        continueButton.isUserInteractionEnabled = true
        reloadTableview()
    }
}


