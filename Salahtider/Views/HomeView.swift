//
//  ContentView.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//

import Combine
import SwiftUI

struct HomeView: View {
    @StateObject var selectedCity = CityManager()
    let cities: [String] = ["copenhagen", "arhus", "odense" , "malmo"]
    
    @StateObject var viewModel = ViewModelImpl(service: ServiceImpl())
    
    //@State private var prayerTimes = [PrayerTime]()
    
    @State private var date = Date()
    
    
    //    var dateFormatter: DateFormatter {
    //        let string = "Wed, 30 Oct 2020"
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "EEEE d MMMM yyyy"
    //        print(formatter.date(from: string) ?? "Unknown date")
    //        return formatter
    //    }
    //
    
    var dateFormatterAr: DateFormatter {
        let formatter = DateFormatter()
        let islamicCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        formatter.calendar = islamicCalendar
        formatter.locale = Locale.init(identifier: "en_ar")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }
    
    
    enum prayerName: String {
        case fajr = "fajr"
        case shuruk = "shuruk"
        case dhuhr = "dhuhr"
        case asr = "asr"
        case hanafi = "hanafi asr"
        case maghrib = "maghrib"
        case isha = "isha"
    }
    
    
    
    var body: some View {
        
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
                
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getPrayerTimes)
                
            case .success(let prayerTimes):
                NavigationView {
                    Form {
                        Section(header: Text("Choose a city")) {
                            Picker("Choose a city", selection: $selectedCity.index) {
                                ForEach(0 ..< cities.count) {
                                    Text("\(self.cities[$0])")
                                    
                                }
                                
                            }.pickerStyle(SegmentedPickerStyle())
                            .onReceive(selectedCity.publisher) { _ in
                                viewModel.getPrayerTimes()
                                
                            }
                            
                        }
                        
                        
                        
                        Section{
                            List(prayerTimes) {prayertime in
                                PrayerTimeRow(prayerName: "Fajr", prayerTime: prayertime, prayerIcon: "sunrise.fill", bgColor: Color.black)
                                
                            }
                        }
                    }
                }
                
            }
            
        }.onAppear(perform: viewModel.getPrayerTimes)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
