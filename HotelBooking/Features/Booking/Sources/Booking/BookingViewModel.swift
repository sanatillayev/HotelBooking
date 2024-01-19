//
//  BookingViewModel.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Models
import Combine
import UIComponents

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
        case .addFirstTourist:
            addfirstTourist()
        case .setPhoneNumber(let newNumber): break
//            self.state.phoneNumber = newNumber
        case .setEmail(let newEmail):
            self.state.email = newEmail
        case .findTotalPrice:
            calculateTotalPrice()
        case .addTourist:
            addNextTourist()
        case .setName(let name):
            self.state.firstTourist.name = name
        case .setSurname(let surname):
            self.state.firstTourist.surname = surname
        case .setBirthdate(let birthdate):
            self.state.firstTourist.birthday = birthdate
        case .setCitizenship(let citizenship):
            self.state.firstTourist.citizenship = citizenship
        case .setIdNumber(let idNumber):
            self.state.firstTourist.idNumber = idNumber
        case .setExpiryDate(let expiryDate):
            self.state.firstTourist.expiryDate = expiryDate
        case .setSecondName(let name):
            self.state.secondTourist.name = name
        case .setSecondSurname(let surname):
            self.state.secondTourist.surname = surname
        case .setSecondBirthdate(let birthdate):
            self.state.secondTourist.birthday = birthdate
        case .setSecondCitizenship(let citizenship):
            self.state.secondTourist.citizenship = citizenship
        case .setSecondIdNumber(let idNumber):
            self.state.secondTourist.idNumber = idNumber
        case .setSecondExpiryDate(let expiryDate):
            self.state.secondTourist.expiryDate = expiryDate
        case .setThirdName(let name):
            self.state.thirdTourist.name = name
        case .setThirdSurname(let surname):
            self.state.thirdTourist.surname = surname
        case .setThirdBirthdate(let birthdate):
            self.state.thirdTourist.birthday = birthdate
        case .setThirdCitizenship(let citizenship):
            self.state.thirdTourist.citizenship = citizenship
        case .setThirdIdNumber(let idNumber):
            self.state.thirdTourist.idNumber = idNumber
        case .setThirdExpiryDate(let expiryDate):
            self.state.thirdTourist.expiryDate = expiryDate
        case .setFourthName(let name):
            self.state.fourthTourist.name = name
        case .setFourthSurname(let surname):
            self.state.fourthTourist.surname = surname
        case .setFourthBirthdate(let birthdate):
            self.state.fourthTourist.birthday = birthdate
        case .setFourthCitizenship(let citizenship):
            self.state.fourthTourist.citizenship = citizenship
        case .setFourthIdNumber(let idNumber):
            self.state.fourthTourist.idNumber = idNumber
        case .setFourthExpiryDate(let expiryDate):
            self.state.fourthTourist.expiryDate = expiryDate
        case .setFifthName(let name):
            self.state.fifthTourist.name = name
        case .setFifthSurname(let surname):
            self.state.fifthTourist.surname = surname
        case .setFifthBirthdate(let birthdate):
            self.state.fifthTourist.birthday = birthdate
        case .setFifthCitizenship(let citizenship):
            self.state.fifthTourist.citizenship = citizenship
        case .setFifthIdNumber(let idNumber):
            self.state.fifthTourist.idNumber = idNumber
        case .setFifthExpiryDate(let expiryDate):
            self.state.fifthTourist.expiryDate = expiryDate

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
    
    private func emptyTourists() {
        state.tourists.removeAll()
    }
    
    private func calculateTotalPrice() {
        Task(priority: .high) { @MainActor [unowned self] in
            state.isLoading = true
            do {
                let tour = try await worker.fetchTourData()
                let totalPrice = tour.fuelCharge + tour.serviceCharge + tour.tourPrice
                state.totalPrice = totalPrice
                state.isLoading = false
            } catch {
                print("Error fetching tour data: \(error)")
                state.isLoading = false
            }
        }
    }
    private func addfirstTourist() {
        if state.tourists.isEmpty {
            state.tourists.append(state.firstTourist)
        }
    }

    private func addNextTourist() {
        var nextTourist: Tourist? = nil
        switch state.tourists.count {
        case 0:
            nextTourist = state.firstTourist
        case 1:
            nextTourist = state.secondTourist
        case 2:
            nextTourist = state.thirdTourist
        case 3:
            nextTourist = state.fourthTourist
        case 4:
            nextTourist = state.fifthTourist
        default:
            print("max # of tourists is 5")
            break
        }

        if let nextTourist = nextTourist {
            state.tourists.append(nextTourist)
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
        case setName(String)
        case setSurname(String)
        case setBirthdate(String)
        case setCitizenship(String)
        case setIdNumber(String)
        case setExpiryDate(String)
        case setSecondName(String)
        case setSecondSurname(String)
        case setSecondBirthdate(String)
        case setSecondCitizenship(String)
        case setSecondIdNumber(String)
        case setSecondExpiryDate(String)
        case setThirdName(String)
        case setThirdSurname(String)
        case setThirdBirthdate(String)
        case setThirdCitizenship(String)
        case setThirdIdNumber(String)
        case setThirdExpiryDate(String)
        case setFourthName(String)
        case setFourthSurname(String)
        case setFourthBirthdate(String)
        case setFourthCitizenship(String)
        case setFourthIdNumber(String)
        case setFourthExpiryDate(String)
        case setFifthName(String)
        case setFifthSurname(String)
        case setFifthBirthdate(String)
        case setFifthCitizenship(String)
        case setFifthIdNumber(String)
        case setFifthExpiryDate(String)
        case findTotalPrice
    }

    struct State {
        var isLoading = false
        var tour: Tour? = nil
        var tourists: [Tourist] = []
        var firstTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
        var secondTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
        var thirdTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
        var fourthTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
        var fifthTourist = Tourist(name: "", surname: "", birthday: "", citizenship: "", idNumber: "", expiryDate: "")
        var touristBindings: [Int:Binding<Tourist>] = [:]
        var phoneNumber = PhoneNumberFormatterBinding()
        var email: String = ""
        var totalPrice: Int = 0
        var isSuperButtonDisabled: Bool{
            (firstTourist.name?.isEmpty) ?? true ||
            (firstTourist.surname?.isEmpty) ?? true ||
            (firstTourist.birthday?.isEmpty) ?? true ||
            (firstTourist.citizenship?.isEmpty) ?? true ||
            (firstTourist.idNumber?.isEmpty) ?? true ||
            (firstTourist.expiryDate?.isEmpty) ?? true ||
            /*phoneNumber.isEmpty ||*/ email.isEmpty
        }
    }
}
