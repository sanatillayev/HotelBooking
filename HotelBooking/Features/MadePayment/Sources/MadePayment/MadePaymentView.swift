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
    static let header: String = "Ваш заказ принят в работу"
    static let infoText = "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
    static let titleFont = Font.system(size: 22, weight: .medium)
    static let subtitleFont = Font.system(size: 16, weight: .regular)

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
        VStack(alignment: .center, spacing: .zero) {
            Image(String.AppIcons.icDone)
                .frame(width: 94, height: 94)
                .padding(.top, 122)
            Text(Constants.header)
                .font(Constants.titleFont)
                .padding(.bottom, 20)
                .padding(.top, 32)
            Text(Constants.infoText)
                .font(Constants.subtitleFont)
                .foregroundStyle(Color.AppColors.clLabelSecondary)
                .padding(.horizontal, 23)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .navigation(router)
        .safeAreaInset(edge: .top, content: { header } )
        .safeAreaInset(edge: .bottom, content: { buttonView } )
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HeaderActionView(title: Constants.title) {
            closeView()
        }
    }
    
    private var buttonView: some View {
        ButtonView(title: "Супер!", showDivider: true) {
            router.closeView()
        }
    }
}
