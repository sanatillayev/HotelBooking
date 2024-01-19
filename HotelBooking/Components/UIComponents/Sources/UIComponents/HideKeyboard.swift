//
//  HideKeyboard.swift
//
//
//  Created by Bilol Sanatillayev on 19/01/24.
//

import SwiftUI


public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
