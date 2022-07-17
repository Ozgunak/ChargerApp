//
//  FilterViewController.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet var filterButtonCollection: [FilterButton]!
    @IBOutlet weak var filterButton: FilterButton!
    @IBOutlet weak var sliderView: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TEMİZLE", style: .plain, target: self, action: #selector(clearPressed))
        navigationItem.title = "Filtreleme"
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    var filters = FilterModel()
    var filterArray = [String]()
    var completion: ((_ model: FilterModel) -> ())?

    @objc func clearPressed() {
        filters.distance = 15
        sliderView.value = 15
        filters.AC = false
        filters.DC = false
        filters.type2 = false
        filters.ccs = false
        filters.chademo = false
        filters.otopark = false
        filters.bufe = false
        filters.wifi = false
        filterButtonCollection.forEach { button in
            button.active = false
        }
    }
    
    @IBAction func buttonPressed(_ sender: FilterButton) {
        sender.active = !sender.active
        switch sender.tag {
        case 1:
            filters.AC = !filters.AC
        case 2:
            filters.DC = !filters.DC
        case 3:
            filters.type2 = !filters.type2
        case 4:
            filters.ccs = !filters.ccs
        case 5:
            filters.chademo = !filters.chademo
        case 6:
            filters.otopark = !filters.otopark
        case 7:
            filters.bufe = !filters.bufe
        case 8:
            filters.wifi = !filters.wifi
        default:
            break
        }
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let step: Float = 3
        let roundedValue = round(sender.value  / step) * step
        sender.value = roundedValue
        filters.distance = roundedValue
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        if let completion = completion {
            completion(filters)
        }
        navigationController?.popViewController(animated: true)
    }
}

class FilterModel {
    var AC: Bool = false
    var DC: Bool = false
    var type2: Bool = false
    var ccs: Bool = false
    var chademo: Bool = false
    var otopark: Bool = false
    var bufe: Bool = false
    var wifi: Bool = false
    var distance: Float = 15
}
