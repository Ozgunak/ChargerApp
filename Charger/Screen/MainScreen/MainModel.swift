//
//  MainModel.swift
//  Charger
//
//  Created by ozgun on 9.07.2022.
//

import Foundation

struct AppointmentModel: Codable, Equatable {
    static func == (lhs: AppointmentModel, rhs: AppointmentModel) -> Bool {
        lhs.appointmentID == rhs.appointmentID
    }
    
    var time: String?
    var date: String?
    var station: StationModel?
    var stationCode: String?
    var stationName: String?
    var userID: Int?
    var appointmentID: Int?
    var socketID: Int?
    var hasPassed: Bool?
}

