//
//  MadePaymentBuilder.swift
//
//
//  Created by Bilol Sanatillayev on 07/01/24.
//

import SwiftUI

public class MadePaymentBuilder {
    public static func createMadePaymentScene (
        presentationType: Binding<Bool>,
        onDismiss: @escaping () -> Void
    ) -> MadePaymentView {
        let viewModel = MadePaymentViewModel()
            let router = MadePaymentRouter(presentationType: presentationType, onDismiss: onDismiss)
        let view = MadePaymentView(viewModel: viewModel, router: router)
        return view
    }
}
