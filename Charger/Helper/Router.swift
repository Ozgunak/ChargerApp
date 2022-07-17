//
//  Router.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

protocol Routable {
    func routeToMain(from navigationController: UINavigationController)
    func routeToSelection(from navigationController: UINavigationController, selectedStation: StationModel)
    func routeToLogin(from navigationController: UINavigationController)

}
class Router: Routable {
    
    func routeToMain(from navigationController: UINavigationController) {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToLogin(from navigationController: UINavigationController) {
        let sb: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController.show(vc, sender: navigationController)
    }
    
    func routeToSelection(from navigationController: UINavigationController, selectedStation: StationModel) {
        let sb: UIStoryboard = UIStoryboard(name: "Selection", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        vc.selectedStation = selectedStation
        navigationController.pushViewController(vc, animated: true)
    }


}
