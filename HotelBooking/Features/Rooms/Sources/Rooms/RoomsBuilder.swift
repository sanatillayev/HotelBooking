//
//  RoomsBuilder.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Models

public class RoomsBuilder {
    public static func createRoomsListScene (
        presentationType: Binding<Bool>,
        hotel: Hotel,
        onDismiss: @escaping () -> Void
    ) -> RoomsView {
        let worker = RoomsWorker()
        let viewModel = RoomsViewModel(worker: worker, hotel: hotel)
        let router = RoomsRouter(presentationType: presentationType, onDismiss: onDismiss)
        let view = RoomsView(router: router, viewModel: viewModel)
        return view
    }
}
