//
//  Date+Extension.swift
//  Salahtider
//
//  Created by Lamin Tamba on 20/04/2021.
//

import Foundation

extension DateFormatter {
    
    static var dateFormatterAr: DateFormatter {
        let formatter = DateFormatter()
        let islamicCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        formatter.calendar = islamicCalendar
        formatter.locale = Locale.init(identifier: "en_ar")
        formatter.dateFormat = " d MMMM yyyy"
        return formatter
    }
    

   
}
