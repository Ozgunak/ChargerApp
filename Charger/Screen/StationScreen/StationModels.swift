//
//  StationModels.swift
//  Charger
//
//  Created by ozgun on 1.07.2022.
//

import Foundation

struct StationModel: Codable {
    var id: Int?
    var stationCode: String?
    var sockets: [SocketModel]?
    var socketCount: Int?
    var occupiedSocketCount: Int?
    var distanceInKM: Double?
    var services: [String]?
    var geoLocation: GeoLocationModel?
    var stationName: String?
}

struct SocketModel: Codable {
    var socketID: Int?
    var socketType: String?
    var chargeType: String?
    var power: Int?
    var powerUnit: String?
    var socketNumber: Int?
}

struct GeoLocationModel: Codable {
    var longitude: Double?
    var latitude: Double?
    var province: String?
    var address: String?
}
