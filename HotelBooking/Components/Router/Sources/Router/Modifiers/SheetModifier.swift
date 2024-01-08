//
//  SheetModifier.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI

public struct SheetModifier: ViewModifier {

    @Binding public var presentingView: AnyView?

    public func body(content: Content) -> some View {
        content.sheet(isPresented: Binding( get: { self.presentingView != nil },
                                            set: { if !$0 { self.presentingView = nil }})) { self.presentingView }
    }
}
