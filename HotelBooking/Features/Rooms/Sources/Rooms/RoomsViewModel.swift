//
//  RoomsViewModel.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import CoreModels
import Combine

final class RoomsViewModel: ObservableObject {
    
    // MARK: Public Properties
    
    @Published private(set) var state: State
    let action = PassthroughSubject<Action, Never>()
    
    // MARK: Private properties

    private let worker: AnyRoomsWorker
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Init

    init(worker: AnyRoomsWorker, hotel: Hotel) {
        self.worker = worker
        self.state = State(hotel: hotel)
        
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
            fetchRoomsData()
        }
    }
    
    private func fetchRoomsData() {
        state.isLoading = true
        worker.fetchRoomsData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error while fetching hotel data: \(error)")
                    self.state.isLoading = false
                }
            }, receiveValue: { rooms in
                self.state.rooms = rooms.rooms
                for room in self.state.rooms {
                    self.downloadRoomImages(for: room)
                }
            })
            .store(in: &cancellables)
    }

    private func downloadRoomImages(for room: Room) {
        state.isLoading = true
        var images: [UIImage] = []
        let dispatchGroup = DispatchGroup()

        for urlString in room.imageUrls {
            guard let url = URL(string: urlString) else { continue }

            dispatchGroup.enter()

            worker.downloadImage(url: url)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error while downloading images: \(error)")
                    }
                    dispatchGroup.leave()
                }, receiveValue: { image in
                    if let image = image {
                        images.append(image)
                    }
                })
                .store(in: &cancellables)
        }

        dispatchGroup.notify(queue: .main) {
            self.state.roomImages[room.id] = images
            self.state.isLoading = false
        }
    }

}


// MARK: - ViewModel Actions & State

extension RoomsViewModel {

    enum Action {
        case fetchRooms
    }

    struct State {
        var isLoading = false
        var hotel: Hotel
        var rooms: [Room] = []
        var imageDownloadPublishers: [AnyPublisher<UIImage?, Error>] = []
        var roomImages: [Int : [UIImage]] = [:]
    }
}
