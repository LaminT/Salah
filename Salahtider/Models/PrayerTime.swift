//
//  PrayerTime.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//

import Foundation


// MARK: - PrayerTimeResponse
struct PrayerTimeResponse: Codable {
    let date: String
    let prayerTimes: [PrayerTime]
}

// MARK: - PrayerTime
struct PrayerTime: Codable, Identifiable {
    let id = UUID()
    let fajr, shuruk, dhuhr, asr: String?
    let maghrib, isha, hanafiASR: String?

    enum CodingKeys: String, CodingKey {
        case fajr, shuruk, dhuhr, asr, maghrib, isha
        case hanafiASR = "hanafi asr"
    }
}

extension PrayerTime {
    static var dummyData: PrayerTime {
        .init(fajr: "03:44",
              shuruk: "05:49",
              dhuhr: "13:09",
              asr: "17:05",
              maghrib: "20:29",
              isha: "22:36",
              hanafiASR: "18:06")
    }
}


