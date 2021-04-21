//
//  ResultState.swift
//  Salahtider
//
//  Created by Lamin Tamba on 20/04/2021.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [PrayerTime])
    case failed(error: Error)
}
