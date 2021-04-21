//
//  CityManager.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//
//
import SwiftUI
import Combine

#warning("No longer needed")
//class CityManager: ObservableObject {
//    
//    @Published var index = 0 {
//        didSet {
//            if let city = Cities(rawValue: index) {
//                activeCity.send(city)
//            }
//        }
//    }
//    
//    var city: Cities {
//        Cities(rawValue: index)!
//    }
//    
//    
//   // let activeCity = CurrentValueSubject<Cities, Never>(Cities.allCases.first!)
//}

// Move this to a different file
enum City: String, CaseIterable, Identifiable {
    
    var id: UUID {
        UUID()
    }
    
    case copenhagen
    case arhus
    case odense
    case malmo
    
    
}
