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
    #warning("This is where we have to pass the city in so we can create a query param to send to the service")
    case getPrayerTime(city: City)
}


//struct Citites {
//    var selectedCity = CityManager()
//    let cities: [String] = ["copenhagen", "arhus", "odense" , "malmo"]
//}

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
            return URL(string: "http://salah.dk")!
        }
    }
    
    var path: String {
        return "/ws.php"
    }
    
    var urlRequest: URLRequest {
        
        switch self {
        case .getPrayerTime(let city):
            
            #warning("This is where we build the query string for the request notice how i seperated it")
            var urlComponents = URLComponents(string: self.baseUrl.appendingPathComponent(self.path).absoluteString)
            urlComponents?.queryItems = [
                URLQueryItem(name: "city", value: city.rawValue)
            ]
            // Force unwrapping cos i know this won't be nil
            return URLRequest(url: urlComponents!.url!)

        }

    }
}
