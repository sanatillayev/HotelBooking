//
//  BookingRouter.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import Router
import SwiftUI
import MadePayment

protocol AnyBookingRouter{
    func closeView()
}
final class BookingRouter: Router, AnyBookingRouter {
    
    private let onDismiss: () -> Void
    
    init(presentationType: Binding<Bool>, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        super.init(presentationType: presentationType)
    }
    
    // MARK: - Public Methods
        
    func showMadePayment() {
        let view = MadePaymentBuilder.createMadePaymentScene(presentationType: isNavigating) {
            self.closeView()
        }
        self.navigateTo(view)
    }
    
    func closeView() {
        onDismiss()
        self.dismiss()
    }

}
