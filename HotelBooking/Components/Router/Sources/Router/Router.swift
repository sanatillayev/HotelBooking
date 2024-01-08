//
//  Router.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI

open class Router: ObservableObject {

    /// Состояние навигации
    public struct State {
        public var coverSheet: AnyView?
        public var navigating: AnyView?
        public var presentingSheet: AnyView?
        public var presentationType: Binding<Bool>
    }

    @Published private(set) public var state: State

    public init(presentationType: Binding<Bool>) {
        state = State(presentationType: presentationType)
    }
}

public extension Router {

    /// Для перехода к другой вью черeз навигейшн
    func navigateTo<V: View>(_ view: V) {
        state.navigating = AnyView(view)
    }
    /// Показ листа поверх контента
    func presentSheet<V: View>(_ view: V) {
        state.presentingSheet = AnyView(view)
    }
    func coverSheet<V: View>(_ view: V) {
        state.coverSheet = AnyView(view)
    }
    /// убрать экран
    func dismiss() {
        state.presentationType.wrappedValue = false
    }
}

public extension Router {

    var isNavigating: Binding<Bool> {
        boolBinding(keyPath: \.navigating)
    }
    var isCover: Binding<Bool> {
        boolBinding(keyPath: \.coverSheet)
    }
    var isPresentingSheet: Binding<Bool> {
        boolBinding(keyPath: \.presentingSheet)
    }
    var isPresented: Binding<Bool> {
        state.presentationType
    }
}

private extension Router {

    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }

    func boolBinding<T>(keyPath: WritableKeyPath<State, T?>) -> Binding<Bool> {
        Binding(
            get: { self.state[keyPath: keyPath] != nil },
            set: {
                if !$0 {
                    self.state[keyPath: keyPath] = nil
                }
            }
        )
    }
}

public extension View {
    
    func navigation(_ router: Router) -> some View {
        self.modifier(NavigationModifier(presentingView: router.binding(keyPath: \.navigating)))
    }
    
    func sheet(_ router: Router) -> some View {
        self.modifier(SheetModifier(presentingView: router.binding(keyPath: \.presentingSheet)))
    }
    
    func cover(_ router: Router) -> some View {
        self.modifier(CoverModifier(presentingView: router.binding(keyPath: \.coverSheet)))
    }
}
