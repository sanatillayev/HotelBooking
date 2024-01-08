//
//  HotelBookingApp.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Hotel
import CoreModels
import Rooms
import Booking

@main
struct HotelBookingApp: App {
    var body: some Scene {
        WindowGroup {
            HotelBuilder.createHotelScene(presentationType: .constant(true))
        }
    }
}
