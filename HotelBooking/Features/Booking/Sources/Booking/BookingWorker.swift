//
//  BookingWorker.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Router
import CoreModels
import Combine

protocol AnyBookingWorker {
    func fetchTourData() -> AnyPublisher<Tour, Error>
}
public final class BookingWorker: AnyBookingWorker {
    let url = URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195")!

    func fetchTourData() -> AnyPublisher<Tour, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Tour.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
