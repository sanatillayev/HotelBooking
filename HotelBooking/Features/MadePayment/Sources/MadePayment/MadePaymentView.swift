//
//  MadePaymentView.swift
//
//
//  Created by Bilol Sanatillayev on 07/01/24.
//

import SwiftUI
import UIComponents
import Router

private enum Constants {
    
    static let title: String = "Заказ оплачен"
}

public struct MadePaymentView: View {
    
    @StateObject var viewModel: MadePaymentViewModel
    @StateObject var router: MadePaymentRouter
    
    // MARK: - Routing
    
    func closeView() {
        router.dismiss()
    }
    
    // MARK: - Life Cycle
    public var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: .zero) {
                    Text("payment made view")
                        .onTapGesture {
                            router.closeView()
                        }
                }
            }
            .navigation(router)
            .safeAreaInset(edge: .top, content: { header } )
            .toolbar(.hidden, for: .navigationBar)
    }
}

extension MadePaymentView {
    
    private var header: some View {
        HeaderActionView(title: Constants.title) {
            closeView()
        }
    }
}
