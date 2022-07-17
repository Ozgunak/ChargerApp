//
//  MainViewController.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var createAppoinmentButton: UIButton!
    @IBOutlet weak var leafImage: UIImageView!
    @IBOutlet weak var noAppLabel: UILabel!
    @IBOutlet weak var noApp2Label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: MainLogic?
    var router: Routable?
    let headers = ["Güncel Randevular", "Geçmiş Randevular"]

    var appointments: [AppointmentModel] = []
    
    var outdatedAppointments: [AppointmentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        interactor?.getAppointments(completion: { models in
            self.appointments = models
            self.checkDates()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDates()
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateUI()
        }
    }
    
    func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let router = Router()
        viewController.interactor = interactor
        viewController.router = router
        let nib = UINib(nibName: "AppointmentsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AppointmentsTableViewCell")
    }

    func setupUI() {
        createAppoinmentButton.layer.cornerRadius = createAppoinmentButton.frame.height / 2
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profilePressed))
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.title = "Randevular"
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        updateUI()
    }
    
    func updateUI() {
        leafImage.isHidden = appointments.isEmpty ? false : true
        noAppLabel.isHidden = appointments.isEmpty ? false : true
        noApp2Label.isHidden = appointments.isEmpty ? false : true
        tableView.isHidden = appointments.isEmpty ? true : false
    }
    
    func checkDates() {
        appointments.indices.forEach { index in
            let dateString = "\(appointments[index].date ?? "") \(appointments[index].time ?? "")"
            guard let date = dateString.toDate() else { return }
            if date < Date() || !outdatedAppointments.contains(appointments[index]){
                outdatedAppointments.append(appointments[index])
            }
        }
        
//        for item in outdatedAppointments {
//            appointments.removeAll { appModel in
//                appModel == item
//            }
//        }

        reload()
    }

    @objc func profilePressed() {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createAppoinmentButtonPressed(_ sender: UIButton) {
        let sb: UIStoryboard = UIStoryboard(name: "CreateCities", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CreateCitiesViewController") as! CreateCitiesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return appointments.count
        case 1: return outdatedAppointments.count
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return outdatedAppointments.isEmpty ? 1 : 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentsTableViewCell", for: indexPath) as! AppointmentsTableViewCell
        if indexPath.section == 0 {
            cell.set(model: appointments[indexPath.row])
        } else {
            cell.set(model: outdatedAppointments[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


    

