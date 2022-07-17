//
//  AlertViewController.swift
//  Charger
//
//  Created by ozgun on 12.07.2022.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet var outsideView: UIView!
    @IBOutlet weak var secButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var alertTitle: String = ""
    var alertSubtitle: String = ""
    var alertButton1: String = ""
    var alertButtton2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(outsideTouched))
        outsideView.addGestureRecognizer(gesture)
    }

    init(title: String, subtitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertSubtitle = subtitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func secButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func outsideTouched() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
