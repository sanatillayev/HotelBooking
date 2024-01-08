//
//  BookingBuilder.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI

public final class BookingBuilder{
    
    public static func createHotelScene(
        presentationType: Binding<Bool>,
        onDismiss: @escaping () -> Void
    ) -> BookingView {
        let router = BookingRouter(presentationType: presentationType, onDismiss: onDismiss)
        let worker = BookingWorker()
        let viewModel = BookingViewModel(worker: worker)
        let view = BookingView(viewModel: viewModel, router: router)
        return view
    }
}
