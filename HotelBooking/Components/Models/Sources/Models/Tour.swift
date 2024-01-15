//
//  Tour.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import Foundation

// MARK: - Tour
public struct Tour: Codable {
    public let id: Int
    public let hotelName, hotelAdress: String
    public let horating: Int
    public let ratingName, departure, arrivalCountry, tourDateStart: String
    public let tourDateStop: String
    public let numberOfNights: Int
    public let room, nutrition: String
    public let tourPrice, fuelCharge, serviceCharge: Int

    public enum CodingKeys: String, CodingKey {
        case id
        case hotelName = "hotel_name"
        case hotelAdress = "hotel_adress"
        case horating
        case ratingName = "rating_name"
        case departure
        case arrivalCountry = "arrival_country"
        case tourDateStart = "tour_date_start"
        case tourDateStop = "tour_date_stop"
        case numberOfNights = "number_of_nights"
        case room, nutrition
        case tourPrice = "tour_price"
        case fuelCharge = "fuel_charge"
        case serviceCharge = "service_charge"
    }
}

// MARK: - Tourist
public struct Tourist {
    public var name: String?
    public var surname: String?
    public var birthday: String?
    public var citizenship: String?
    public var idNumber: String?
    public var expiryDate: String?
    
    public init(name: String? = nil, surname: String? = nil, birthday: String? = nil, citizenship: String? = nil, idNumber: String? = nil, expiryDate: String? = nil) {
        self.name = name
        self.surname = surname
        self.birthday = birthday
        self.citizenship = citizenship
        self.idNumber = idNumber
        self.expiryDate = expiryDate
    }
}
