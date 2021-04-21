//
//  Service.swift
//  Salahtider
//
//  Created by Lamin Tamba on 20/04/2021.
//

import Combine
import Foundation

protocol Service {
    func request(from endpoint: PrayerTimeAPI) -> AnyPublisher<PrayerTimeResponse, APIError>
}

struct ServiceImpl: Service {
    
    func request(from endpoint: PrayerTimeAPI) -> AnyPublisher<PrayerTimeResponse, APIError> {
        
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<PrayerTimeResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if(200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: PrayerTimeResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
