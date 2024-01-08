//
//  Rooms.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import Foundation

public struct Rooms: Codable, Hashable {
    public let rooms: [Room]
}
// MARK: - Room
public struct Room: Codable, Hashable {
    public let id: Int
    public let name: String
    public let price: Int
    public let pricePer: String
    public let peculiarities: [String]
    public let imageUrls: [String]

    public enum CodingKeys: String, CodingKey {
        case id, name, price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}
