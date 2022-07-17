//
//  RezDetailInteractor.swift
//  Charger
//
//  Created by ozgun on 9.07.2022.
//


import UIKit

protocol RezLogic {
    func getRezervation(station: Int,socketID: Int,timeSlot: String,appointmentDate: String, completion: @escaping (Bool) -> Void)
}

class RezDetailInteractor: RezLogic {
    
    func getRezervation(station: Int, socketID: Int, timeSlot: String, appointmentDate: String, completion: @escaping (Bool) -> Void) {
        let userID = User.userModel.userID ?? 0
        let userToken = User.userModel.token ?? ""
        let lon = User.location.longditude ?? 28.979530
        let lat = User.location.latitude ?? 41.015137
        
        let param: [String: Any] = ["stationID": station,
                                    "socketID": socketID,
                                    "timeSlot": timeSlot,
                                    "appointmentDate": appointmentDate
        ]
        print(param)
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/make?userID=\(userID)") else { return }
        
//        &userLatitude=\(lat)&userLongitude=\(lon)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(userToken, forHTTPHeaderField: "token")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(String(describing: error!))
                return
            }
            guard let httpUrlResponse = response as? HTTPURLResponse, (200...299).contains(httpUrlResponse.statusCode) else { return }
            if let safeData = data {
                do {
                    let appointmentModel = try JSONDecoder().decode(RezModel.self, from: safeData)
                    completion(true)
                }
                catch let error {
                    completion(false)
                    print(String(describing: error))
                }
            }
        }
        
        task.resume()
    }
}

struct RezModel: Codable {
    
}
