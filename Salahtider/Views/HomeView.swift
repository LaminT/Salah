//
//  ContentView.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//

import Combine
import SwiftUI

struct HomeView: View {
    
    
   // @StateObject var cityManager = CityManager()
    //private let cities: [String] = ["copenhagen", "arhus", "odense" , "malmo"]
    
    @StateObject var viewModel = ViewModelImpl(service: ServiceImpl())
    
    //@State private var prayerTimes = [PrayerTime]()
    
    @State private var date = Date()
    @State private var activeCity: String = City.allCases.first!.rawValue
    
    private var city: City {
        City(rawValue: activeCity)!
    }
    
    //    var dateFormatter: DateFormatter {
    //        let string = "Wed, 30 Oct 2020"
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "EEEE d MMMM yyyy"
    //        print(formatter.date(from: string) ?? "Unknown date")
    //        return formatter
    //    }
    //
    
    // Move this into an extension
    var dateFormatterAr: DateFormatter {
        let formatter = DateFormatter()
        let islamicCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        formatter.calendar = islamicCalendar
        formatter.locale = Locale.init(identifier: "en_ar")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }
    
    // Move this into a seperate file
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
                
                ErrorView(error: error) {
                    
                    viewModel.getPrayerTimes(in: city)
                }
                
                
            case .success(let prayerTimes):
                NavigationView {
                    Form {
                        
                        Text("Value: \(activeCity)")

                        
                        Section(header: Text("Choose a city")) {
                            Picker("Choose a city",
                                   selection: $activeCity) {
                                // Made a change here so it will be built based of your enum, so all you need to do is update your enum in the future look at how i use identifiable
                                ForEach(City.allCases.map { $0.rawValue },
                                        id: \.self) { city in
                                    Text(city)
                                }
                                
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .onChange(of: activeCity,
                                      perform: { _ in
                                        viewModel.getPrayerTimes(in: city)
                            })
                            
                            
                        }
                        
                        Section{
                            List(prayerTimes) {prayertime in
                                PrayerTimeRow(prayerName: "Fajr", prayerTime: prayertime, prayerIcon: "sunrise.fill", bgColor: Color.black)
                                
                            }
                        }
                    }
                }
                
            }
            #warning("I'm assuming this should be the first city in the list, also i'm not doing inline anymore becuase the function signiture is not void so it won't work so we have to use the closure instead now")
        }
        .onAppear {
            viewModel.getPrayerTimes(in: city)
        }
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
