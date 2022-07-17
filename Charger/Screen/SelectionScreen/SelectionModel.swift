//
//  SelectionModel.swift
//  Charger
//
//  Created by ozgun on 7.07.2022.
//

import UIKit

struct SelectionModel: Codable {
    var stationID: Int?
    var stationCode: String?
    var sockets: [SocketSelectionModel]?
    var geoLocation: GeoLocationModel?
    var services: [String]?
    var distanceInKM: Double?
    var stationName: String?
}

struct SocketSelectionModel: Codable {
    var socketID: Int?
    var day: DayModel?
    var socketType: String?
    var chargeType: String?
    var power: Int?
    var socketNumber: Int?
    var powerUnit: String?
}

struct DayModel: Codable {
    var id: Int?
    var date: String?
    var timeSlots: [SlotModel]?
}

struct SlotModel: Codable {
    var slot: String?
    var isOccupied: Bool?
    var isActive: Bool? = false
}

struct Day {
    var id: Int?
    var date: String?
    var timeSlots: [TimeModel]?
    var socketType: String?
    var chargeType: String?
    var power: Int?
    var socketNumber: Int?
    var powerUnit: String?
}
class TimeModel {
    var slot: String?
    var isOccupied: Bool?
    var isActive: Bool?
    
    init(slot: String, isOccupied: Bool, isActive: Bool = false) {
        self.slot = slot
        self.isOccupied = isOccupied
        self.isActive = isActive
    }
}
class TimesModel {
    var slot: String?
    
    
}
