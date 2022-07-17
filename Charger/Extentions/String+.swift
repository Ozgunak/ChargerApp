//
//  String+.swift
//  Charger
//
//  Created by ozgun on 13.07.2022.
//

import UIKit

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.date(from: self)
    }
}
