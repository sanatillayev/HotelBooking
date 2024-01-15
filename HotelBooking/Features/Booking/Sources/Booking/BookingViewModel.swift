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
    
    @Published var state = State()
    let action = PassthroughSubject<Action, Never>()
    
    // MARK: Private properties

    private let worker: AnyBookingWorker
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Init

    init(worker: AnyBookingWorker) {
        self.worker = worker
        
        action
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.didChange($0)
            })
            .store(in: &cancellables)
    }
    
    // MARK: Private Method

    private func didChange(_ action: Action) {
        switch action {
        case .fetchTour:
            fetchTourData()
        case .addTourist:
            addTourist()
        case .addFirstTourist:
            addFirstTourist()
        case .setPhoneNumber(let newNumber):
            self.state.phoneNumber = newNumber
        case .setEmail(let newEmail):
            self.state.email = newEmail
        case .findTotalPrice:
            calculateTotalPrice()
        }
    }
    
    private func fetchTourData() {
        state.isLoading = true
        Task.detached(priority: .high) { @MainActor [unowned self] in
            do {
                let tour = try await worker.fetchTourData()
                state.tour = tour
                state.isLoading = false
            } catch {
                print("Error while fetching tour data: \(error)")
                state.isLoading = false
            }
        }
    }
    
    private func addTourist() {
        if state.tour != nil {
            let newTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
            state.tourists.append(newTourist)
        }
        updateTouristBindings()
    }
    
    private func addFirstTourist() {
        Task(priority: .high) { @MainActor [unowned self] in
            if self.state.tourists.isEmpty {
                let newTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
                self.state.tourists.append(newTourist)
            }
            updateTouristBindings()
        }
    }
    
    private func emptyTourists() {
        state.tourists.removeAll()
    }
    
    private func updateTouristBindings() {
        for (index, _) in state.tourists.enumerated() {
            let binding = Binding(
                get: { return self.state.tourists[index] },
                set: { newValue in
                    self.state.tourists[index] = newValue
                }
            )
            self.state.touristBindings[index] = binding
        }
    }
    
    private func calculateTotalPrice() {
        Task(priority: .high) { @MainActor [unowned self] in
            do {
                let tour = try await worker.fetchTourData()
                let totalPrice = tour.fuelCharge + tour.serviceCharge + tour.tourPrice
                state.totalPrice = totalPrice
            } catch {
                print("Error fetching tour data: \(error)")
            }
        }
    }
    
}


// MARK: - ViewModel Actions & State

extension BookingViewModel {
    enum Action {
        case fetchTour
        case addTourist
        case addFirstTourist
        case setPhoneNumber(String)
        case setEmail(String)
        case findTotalPrice
    }

    struct State {
        var isLoading = false
        var tour: Tour? = nil
        var tourists: [Tourist] = []
        var touristBindings: [Int:Binding<Tourist>] = [:]
        var phoneNumber: String = ""
        var email: String = ""
        var totalPrice: Int = 0
    }
}
