//
//  HotelModel.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import Foundation

// MARK: - Hotel
public struct Hotel: Codable {
    public let id: Int
    public let name, adress: String
    public let minimalPrice: Int
    public let priceForIt: String
    public let rating: Int
    public let ratingName: String
    public let imageUrls: [String]
    public let aboutTheHotel: AboutTheHotel

    public enum CodingKeys: String, CodingKey {
        case id, name, adress
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
}

// MARK: - AboutTheHotel
public struct AboutTheHotel: Codable {
    public let description: String
    public let peculiarities: [String]
}
