//
//  BookingViewModel.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Models
import Combine

final class BookingViewModel: ObservableObject {
    
    // MARK: Public Properties
    
    @Published private(set) var state = State()
    let action = PassthroughSubject<Action, Never>()
    
    // MARK: Private properties

    private let worker: AnyBookingWorker
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Init

    init(worker: AnyBookingWorker) {
        self.worker = worker
        
        action
            .sink(receiveValue: { [weak self] in
                self?.didChange($0)
            })
            .store(in: &cancellables)
    }
    
    // MARK: Private Method
    
    private func didChange(_ action: Action) {
        switch action {
        case .fetchRooms:
            fetchTourData()
        }
    }
    
    private func fetchTourData() {
        state.isLoading = true
        worker.fetchTourData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Do nothing for success
                case .failure(let error):
                    print("Error while fetching hotel data: \(error)")
                    self.state.isLoading = false
                }
            }, receiveValue: { tour in
                self.state.tour = tour
            })
            .store(in: &cancellables)
    }

}


// MARK: - ViewModel Actions & State

extension BookingViewModel {

    enum Action {
        case fetchRooms
    }

    struct State {
        var isLoading = false
        var tour: Tour? = nil
    }
}
