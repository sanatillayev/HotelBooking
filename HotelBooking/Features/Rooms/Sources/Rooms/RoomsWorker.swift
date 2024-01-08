//
//  RoomsWorker.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Router
import CoreModels
import Combine

protocol AnyRoomsWorker {
    func fetchRoomsData() -> AnyPublisher<Rooms, Error>
    func downloadImage(url: URL) -> AnyPublisher<UIImage?, Error>
}
public final class RoomsWorker: AnyRoomsWorker {
    let url = URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195")!

    func fetchRoomsData() -> AnyPublisher<Rooms, Error> {
            
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Rooms.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
        
    func downloadImage(url: URL) -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
        return image
    }

}
