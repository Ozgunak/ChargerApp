//
//  Date+.swift
//  Charger
//
//  Created by ozgun on 30.06.2022.
//

import Foundation
extension Date {
    func toString(format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func toISOString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        return formatter.string(from: self)
    }
}
