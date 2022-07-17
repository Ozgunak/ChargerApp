//
//  LoginModel.swift
//  Charger
//
//  Created by ozgun on 1.07.2022.
//

struct UserModel: Codable {
    var token: String?
    var userID: Int?
    var email: String?
}

struct LocationModel: Codable {
    var longditude: Double?
    var latitude: Double?
}

struct User {
    static var userModel: UserModel = UserModel()
    static var location: LocationModel = LocationModel()
}
