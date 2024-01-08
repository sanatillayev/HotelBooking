//
//  MadePaymentRouter.swift
//
//
//  Created by Bilol Sanatillayev on 07/01/24.
//

import Router
import SwiftUI
//import Hotel


protocol AnyMadePaymentRouter{
    func closeView()
}
final class MadePaymentRouter: Router, AnyMadePaymentRouter {
    
    private let onDissmiss: () -> Void
    
    init(presentationType: Binding<Bool>, onDismiss: @escaping () -> Void) {
        self.onDissmiss = onDismiss
        super.init(presentationType: presentationType)
    }

    // MARK: - Public Methods
    
    func closeView() {
        self.dismiss()
        onDissmiss()
    }
    
    func showHotelView() {
//        let view = HotelBuilder.createHotelScene(presentationType: isNavigating)
//        
//        navigateTo(view)
    }
    
    
}
