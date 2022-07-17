//
//  LoginInteractor.swift
//  Charger
//
//  Created by ozgun on 30.06.2022.
//

import UIKit

protocol LoginLogic {
    func loginWith(email: String, completion: @escaping (Bool) -> Void)
}

class LoginInteractor: LoginLogic {
    

    
    func loginWith(email: String, completion: @escaping (Bool) -> Void) {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        
        let param: [String: Any] = ["email": email, "deviceUDID": uuid]
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
                    let user = try JSONDecoder().decode(UserModel.self, from: safeData)
                    completion(true)
                    User.userModel = user
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

