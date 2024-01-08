//
//  BookingView.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import UIComponents
import Router

private enum Constants {
    
    static let title: String = "Заказ оплачен"
}

public struct BookingView: View {
    
    @StateObject var viewModel: BookingViewModel
    @StateObject var router: BookingRouter
    
    // MARK: - Routing
    
    func closeView() {
        router.dismiss()
    }
    
    private func showMadePaymentView() {
        router.showMadePayment()
        }
    
    // MARK: - Life Cycle
    public var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: .zero) {
                    Text("booking view")
                        .onTapGesture {
                            showMadePaymentView()
                        }
                }
            }
            .navigation(router)
            .safeAreaInset(edge: .top, content: { header } )
            .toolbar(.hidden, for: .navigationBar)
    }
}

extension BookingView {
    
    private var header: some View {
        HeaderActionView(title: Constants.title) {
            closeView()
        }
    }
}
