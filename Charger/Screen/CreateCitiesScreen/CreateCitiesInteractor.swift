//
//  CreateCitiesInteractor.swift
//  Charger
//
//  Created by ozgun on 1.07.2022.
//

import UIKit

protocol CityLogic {
    func getCities(completion: @escaping ([String]) -> Void)
    
}


class CreateCitiesInteractor: CityLogic {
    
    func getCities(completion: @escaping ([String]) -> Void) {
        let userID = User.userModel.userID ?? 0
        let userToken = User.userModel.token ?? ""
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/provinces?userID=\(userID)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(userToken, forHTTPHeaderField: "token")

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let httpUrlResponse = response as? HTTPURLResponse, (200...299).contains(httpUrlResponse.statusCode) else { return }
            if let safeData = data {
                do {
                    let cityList = try JSONDecoder().decode([String].self, from: safeData)
                    completion(cityList)
                }
                catch let error {
                    completion([])
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}

struct CityModel: Codable {
    var cities: [String]?
}
