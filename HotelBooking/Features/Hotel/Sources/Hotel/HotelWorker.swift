//
//  HotelWorker.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Combine
import CoreModels

protocol AnyHotelWorker {
    func fetchHotelData() -> AnyPublisher<Hotel, Error>
    func downloadImage(url: URL) -> AnyPublisher<UIImage?, Error>
}

final class HotelWorker: AnyHotelWorker {
        
    let hotelURL = URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473")!
    
    func fetchHotelData() -> AnyPublisher<Hotel, Error> {
        URLSession.shared.dataTaskPublisher(for: hotelURL)
            .map(\.data)
            .decode(type: Hotel.self, decoder: JSONDecoder())
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
