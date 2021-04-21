//
//  APIBuilder.swift
//  Salahtider
//
//  Created by Lamin Tamba on 20/04/2021.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum PrayerTimeAPI {
    case getPrayerTime
}


struct Citites {
    var selectedCity = CityManager()
    let cities: [String] = ["copenhagen", "arhus", "odense" , "malmo"]
}

enum cities: String {
    case copenhagen = "copenhagen"
    case arhus = "arhus"
    case odense = "odense"
    case malmo = "malmo"

}




extension PrayerTimeAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getPrayerTime:
            return URL(string: "http://salah.dk/ws.php?")!
        }
    }
    
    var path: String {
        return "city=\(cities.copenhagen)"
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
}
