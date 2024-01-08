//
//  MadePaymentViewModel.swift
//
//
//  Created by Bilol Sanatillayev on 07/01/24.
//

import SwiftUI
import Combine
import CoreModels

final class MadePaymentViewModel: ObservableObject {
    
    // MARK: Public Properties
    
    @Published var state = State()
    let action = PassthroughSubject<Action, Never>()
    
    // MARK: Private properties

    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Init

    init() {
        action
            .sink(receiveValue: { [unowned self] in
                self.didChange($0)
            })
            .store(in: &subscriptions)
    }
    
    // MARK: Private Method
    
    private func didChange(_ action: Action) {
        switch action {
        case .supperButtonIsPressed:
            state.buttonIsPressed = true
        }
    }

}

// MARK: - ViewModel Actions & State

extension MadePaymentViewModel {
    
    enum Action {
        case supperButtonIsPressed
    }
    
    struct State {
        var buttonIsPressed: Bool = false
    }
}

