//
//  MainInteractor.swift
//  Charger
//
//  Created by ozgun on 9.07.2022.
//

import UIKit

protocol MainLogic {
    func getAppointments(completion: @escaping ([AppointmentModel]) -> Void)

}

class MainInteractor: MainLogic {
    
    func getAppointments(completion: @escaping ([AppointmentModel]) -> Void) {
        let userID = User.userModel.userID ?? 0
        let userToken = User.userModel.token ?? ""
        let lon = User.location.longditude ?? 28.979530
        let lat = User.location.latitude ?? 41.015137
        
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/\(userID)?userLatitude=\(lat)&userLongitude=\(lon)") else { return }
        
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
                    let appointmentModel = try JSONDecoder().decode([AppointmentModel].self, from: safeData)
                    completion(appointmentModel)
                }
                catch let error {
                    completion([AppointmentModel()])
                    print(String(describing: error))
                }
            }
        }
        
        task.resume()
    }
}





