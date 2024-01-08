//
//  HotelBuilder.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI

public final class HotelBuilder{
    
    public static func createHotelScene(
        presentationType: Binding<Bool>
    ) -> HotelView {
        let router = HotelRouter(presentationType: presentationType)
        let worker = HotelWorker()
        let viewModel = HotelViewModel(worker: worker)
        let view = HotelView(viewModel: viewModel, router: router)
        return view
    }
}
