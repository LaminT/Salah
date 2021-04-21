//
//  ViewModel.swift
//  Salahtider
//
//  Created by Lamin Tamba on 20/04/2021.
//
import Combine
import Foundation

protocol ViewModel {
    func getPrayerTimes()
}



class ViewModelImpl: ObservableObject, ViewModel {
    
    private let service: Service
    
    private(set) var prayerTimes = [PrayerTime]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    
    init(service: Service) {
        self.service = service
    }
    
    func getPrayerTimes() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getPrayerTime)
            .sink { res in
                switch res {
                
                case .finished:
                    self.state = .success(content: self.prayerTimes)
                    
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.prayerTimes = response.prayerTimes
            }
        self.cancellables.insert(cancellable)
    }
}
