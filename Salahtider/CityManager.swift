//
//  CityManager.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//
//
import SwiftUI
import Combine

class CityManager: ObservableObject {
    @Published var index = 0 {
        didSet {
            publisher.send(index)
        }
    }
    let publisher = PassthroughSubject<Int, Never>()
}
