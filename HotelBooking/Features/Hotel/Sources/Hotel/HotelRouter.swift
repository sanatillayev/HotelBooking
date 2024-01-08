//
//  HotelRouter.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Router
import Rooms
import Booking
import CoreModels

protocol AnyHotelRouter{
    
}
final class HotelRouter: Router, AnyHotelRouter {

    override init(presentationType: Binding<Bool>) {
        super.init(presentationType: presentationType)
    }

    // MARK: - Public Methods

    func showRoomsView(hotel: Hotel , onDismiss: @escaping () -> Void) {
        let view = RoomsBuilder.createRoomsListScene(presentationType: isNavigating, hotel: hotel, onDismiss: onDismiss)
        navigateTo(view)
    }
    
    func closeView() {
        self.dismiss()
    }
    
    
}
