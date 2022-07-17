//
//  CreateCitiesViewController.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

protocol CityDisplayLogic {
    func displayCities()
}

class CreateCitiesViewController: UIViewController, CityDisplayLogic{
       
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: CityLogic?
    var router: Routable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CitiesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CitiesTableViewCell")
        configureKeyboardToolbar()
        navigationItem.title = "Şehir Seçin"
        navigationItem.backButtonDisplayMode = .minimal
        setup()
        interactor?.getCities(completion: { result in
            if result.isEmpty {
                self.cityList = []
            } else {
                self.cityList = result
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    var cityList: [String] = []
    var searchCityList: [String] = []

    //MARK: - Done button toolbar

    func configureKeyboardToolbar() {
        let toolbar = createKeyboardToolbar()
        searchBar.inputAccessoryView = toolbar
    }
    
    func setup() {
        let viewController = self
        let interactor = CreateCitiesInteractor()
        let router = Router()
        viewController.interactor = interactor
        viewController.router = router
        searchBar.delegate = self
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func createKeyboardToolbar() -> UIToolbar {
        let flexibleSpace = UIBarButtonItem.flexibleSpace()
        let doneBarButton = UIBarButtonItem()
        doneBarButton.target = self
        doneBarButton.action = #selector(doneBarButtonTapped(_:))
        doneBarButton.title = "Done"
        doneBarButton.style = .plain
        
        let toolbar = UIToolbar()
        toolbar.items = [flexibleSpace, doneBarButton]
        toolbar.sizeToFit()
        return toolbar
    }
    func displayCities() {
        
    }

    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
    }
    
}

extension CreateCitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell", for: indexPath) as! CitiesTableViewCell
        cell.setup(searchCityList.isEmpty ?  cityList[indexPath.row]: searchCityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCityList.isEmpty ?  cityList.count : searchCityList.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb: UIStoryboard = UIStoryboard(name: "Station", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "StationViewController") as! StationViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
}


extension CreateCitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCityList = []
        if searchBar.text?.count == 0 {
            searchCityList = []
        } else {
            for city in cityList {
                if city.lowercased().contains(searchText.lowercased()) {
                    searchCityList.append(city)
                }
            }
        }
        self.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
