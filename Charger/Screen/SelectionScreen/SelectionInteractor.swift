//
//  SelectionInteractor.swift
//  Charger
//
//  Created by ozgun on 7.07.2022.
//

import UIKit

protocol SelectionLogic {
    func getSelection(station: Int, date: String, completion: @escaping (SelectionModel?) -> Void)

}

class SelectionInteractor: SelectionLogic {
    
    func getSelection(station: Int, date: String, completion: @escaping (SelectionModel?) -> Void) {
    let userID = User.userModel.userID ?? 0
    let userToken = User.userModel.token ?? ""
    guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations/\(station)?userID=\(userID)&date=\(date)") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(userToken, forHTTPHeaderField: "token")

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) { data, response, error in
        if error != nil {
            print(String(describing: error!))
            return
        }
        guard let httpUrlResponse = response as? HTTPURLResponse, (200...299).contains(httpUrlResponse.statusCode) else { return }
        if let safeData = data {
            do {
                let selection = try JSONDecoder().decode(SelectionModel.self, from: safeData)
                completion(selection)
            }
            catch let error {
                completion(nil)
                print(String(describing: error))
            }
        }
    }
        
        task.resume()
    }
}


