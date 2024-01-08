//
//  HotelViewModel.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Combine
import Models


final class HotelViewModel: ObservableObject {
    
    // MARK: Public Properties
    
    @Published var state = State()
    let action = PassthroughSubject<Action, Never>()
    
    // MARK: Private properties

    private let worker: AnyHotelWorker
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Init

    init(worker: AnyHotelWorker) {
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
        case .fetchHotel:
            fetchHotelData()
        }
    }
    
    private func fetchHotelData() {
        state.isLoading = true
        worker.fetchHotelData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Do nothing for success
                case .failure(let error):
                    print("Error while fetching hotel data: \(error)")
                    self.state.isLoading = false
                }
            }, receiveValue: { hotel in
                self.state.hotel = hotel
                self.downloadHotelImages(for: hotel)
            })
            .store(in: &cancellables)
    }
    
    private func downloadHotelImages(for hotel: Hotel) {
        state.isLoading = true
        if state.images.count > 0 {
            state.images.removeAll()
        }
        for urlString in hotel.imageUrls {
            state.isLoading = true
            guard let url = URL(string: urlString) else { return }

            worker.downloadImage(url: url)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error while downloading images: \(error)")
                    }
                }, receiveValue: { [weak self] image in
                    if let image = image {
                        self?.state.images.append(image)
                    }
                })
                .store(in: &cancellables)
        }
        self.state.isLoading = false

    }
    
    
    
}


// MARK: - ViewModel Actions & State

extension HotelViewModel {

    enum Action {
        case fetchHotel
    }

    struct State {
        var isLoading = false
        var hotel: Hotel? = nil
        var images: [UIImage] = []
    }
}
