//
//  SalahRow.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//

import SwiftUI

struct PrayerTimeRow: View {
    
    var prayerName: String
    var prayerTime: PrayerTime
    var prayerIcon: String
    var bgColor: Color
    
    var body: some View {
        HStack {
            HStack {
                
                VStack {
                    Image(systemName: prayerIcon)
                        .renderingMode(.original)
                        .imageScale(.medium)
                        .font(.system(size: 15, weight: .light))
                        .padding(8)
                        .background(bgColor)
                        .clipShape(Circle())
                    
                    
                }.frame(width: 45, height: 45)
                .clipShape(Circle())
                
                Spacer()
                
                Text(prayerName)
                    .bold().modifier(FontModifier(style: .subheadline))
                
                Spacer()
            }
            Spacer()
            
            Text(prayerTime.fajr ?? "")
                .bold().modifier(FontModifier(style: .subheadline))
                .foregroundColor(.secondary)
            
            Text(prayerTime.shuruk ?? "")
                .bold().modifier(FontModifier(style: .subheadline))
                .foregroundColor(.secondary)
            Text(prayerTime.dhuhr ?? "")
                .bold().modifier(FontModifier(style: .subheadline))
                .foregroundColor(.secondary)
            Text(prayerTime.asr ?? "")
                .bold().modifier(FontModifier(style: .subheadline))
                .foregroundColor(.secondary)
            Text(prayerTime.maghrib ?? "")
                .bold().modifier(FontModifier(style: .subheadline))
                .foregroundColor(.secondary)
            
            Text(prayerTime.isha ?? "")
                .bold().modifier(FontModifier(style: .subheadline))
                .foregroundColor(.secondary)
            
        }
        
        
    }
    
}

struct SalahRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeRow(prayerName: "Fajr", prayerTime: PrayerTime.dummyData, prayerIcon: "sunrise.fill", bgColor: Color.blue)
            .previewLayout(.sizeThatFits)
    }
}
