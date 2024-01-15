//
//  BookingWorker.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Router
import Models
import Combine

protocol AnyBookingWorker {
    func fetchTourData() async throws -> Tour
}
public final class BookingWorker: AnyBookingWorker {
    let url = URL(string: "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff")!
    
    func fetchTourData() async throws -> Tour {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            let validData = try handleResponse(data: data, response: response)
            
            // Parse the data into your Tour model
            let decoder = JSONDecoder()
            let tour = try decoder.decode(Tour.self, from: validData)
            return tour
        } catch let error {
            print("Error during data fetching: \(error.localizedDescription)")
            throw error
        }
    }

    func handleResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
        }
        guard let data = data else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
}
