//
//  StationViewController.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

class StationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: StationLogic?
    var router: Routable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let nib = UINib(nibName: "StationTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StationTableViewCell")
        let nib2 = UINib(nibName: "FiltersCollectionViewCell", bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: "FiltersCollectionViewCell")
        navigationItem.title = "İstasyon Seçin"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(filterPressed))
        navigationItem.backButtonDisplayMode = .minimal
        if filterArray.isEmpty {
            collectionView.isHidden = true
        } else {
                collectionView.isHidden = false
        }
        
        interactor?.getStations(completion: { model in
            self.stationList = model
        })
    }
    var stationList: [StationModel] = []{
        didSet{
            sortList()
        }
    }

    var filterArray: [String] = [] {
        didSet {
            collectionView.isHidden = filterArray.isEmpty
        }
    }
    var filters: FilterModel? {
        didSet {
            filterArray.removeAll()
            if filters?.AC ?? false {
                filterArray.append("AC")
            }
            if filters?.DC ?? false {
                filterArray.append("DC")
            }
            if filters?.type2 ?? false {
                filterArray.append("Type2")
            }
            if filters?.ccs ?? false {
                filterArray.append("CCS")
            }
            if filters?.chademo ?? false {
                filterArray.append("CHAdeMO")
            }
            if filters?.otopark ?? false {
                filterArray.append("Otopark")
            }
            if filters?.bufe ?? false {
                filterArray.append("Büfe")
            }
            if filters?.wifi ?? false {
                filterArray.append("Wi-Fi")
            }
            if filters?.distance ?? 15 != 15 {
                filterArray.append(String(filters?.distance ?? 15))
            }
            self.collectionView.reloadData()

        }
    }
    
    @objc func filterPressed() {
        let sb: UIStoryboard = UIStoryboard(name: "Filter", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.completion = { model in
            self.filters = model
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setup() {
        let viewController = self
        let interactor = StationInteractor()
        let router = Router()
        viewController.interactor = interactor
        viewController.router = router
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func sortList() {
        let newList = stationList.sorted { first, sec in
            first.distanceInKM ?? 0 < sec.distanceInKM ?? 0
        }
        DispatchQueue.main.async {
            self.stationList = newList
            self.tableView.reloadData()
        }
    }
}

extension StationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as! StationTableViewCell
        cell.setup(stationList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationList.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        router?.routeToSelection(from: self.navigationController!, selectedStation: stationList[indexPath.row])

    }
    
    
}

extension StationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltersCollectionViewCell", for: indexPath) as! FiltersCollectionViewCell
        cell.setup(text: filterArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterArray.remove(at: indexPath.item)
        collectionView.reloadData()
    }
}

struct StationModel1 {
    var powerSource: String
    var location: String
    var distance: String
    var socket: String
}
