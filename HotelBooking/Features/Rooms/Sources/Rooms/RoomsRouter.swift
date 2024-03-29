//
//  RoomsRouter.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Router
import Booking

protocol AnyRoomsRouter{
    func closeView()
}
final class RoomsRouter: Router, AnyRoomsRouter {
    
    private let onDismiss: () -> Void
    
    init(presentationType: Binding<Bool>, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        super.init(presentationType: presentationType)
    }
    
    // MARK: - Public Methods
        
    func showBookingView() {
        let view = BookingBuilder.createHotelScene(presentationType: self.isNavigating) {
            self.closeView()
        }
        self.navigateTo(view)
    }
    
    func closeView() {
        onDismiss()
        self.dismiss()
    }

}
