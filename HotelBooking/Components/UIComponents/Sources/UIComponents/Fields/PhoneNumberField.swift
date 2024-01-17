//
//  SwiftUIView.swift
//  
//
//  Created by Bilol Sanatillayev on 15/01/24.
//

import SwiftUI
import Combine

public struct PhoneNumberField: View {
    let label: LocalizedStringKey
    @Binding var phoneNumber: String
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void

    // The text shown by the wrapped TextField.
    @State private var textValue: String = ""

    // When the view loads, `textValue` is not synced with `phoneNumber`.
    // This flag ensures we don't try to get a `phoneNumber` out of `textValue`
    // before the view is fully initialized.
    @State private var hasInitialTextValue = false

    public init(
        _ label: LocalizedStringKey,
        phoneNumber: Binding<String>,
        onEditingChanged: @escaping (Bool) -> Void = { _ in },
        onCommit: @escaping () -> Void = {}
    ) {
        self.label = label
        self._phoneNumber = phoneNumber
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }

    public var body: some View {
        TextField(label, text: $textValue, onEditingChanged: { isInFocus in
            // When the field is in focus we replace the field's contents
            // with a plain specifically formatted number. When not in focus, the field
            // is treated as a label and shows the formatted value.
            if isInFocus {
                self.textValue = self.phoneNumber
            } else {
                // Format the phone number and update `textValue`
                self.phoneNumber = self.formatPhoneNumber(self.textValue)
                self.textValue = self.phoneNumber
            }
            self.onEditingChanged(isInFocus)
        }, onCommit: {
            self.onCommit()
        })
        .onReceive(Just(textValue)) {
            guard self.hasInitialTextValue else {
                // We don't have a usable `textValue` yet -- bail out.
                return
            }
            // This is the only place we update `phoneNumber`.
            self.phoneNumber = $0
        }
        .onAppear() {
            self.hasInitialTextValue = true
            // Any `textValue` from this point on is considered valid and
            // should be synced with `phoneNumber`.
            if !self.phoneNumber.isEmpty {
                // Synchronize `textValue` with `phoneNumber`; can't be done earlier
                self.textValue = self.phoneNumber
            }
        }
        .keyboardType(.phonePad)
    }

    // Function to format phone number in the specified format
    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        // Remove non-digit characters
        let digits = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        // Apply the mask
        var formattedNumber = "+7 "
        
        var index = digits.startIndex
        while index < digits.endIndex {
            let endIndex = digits.index(index, offsetBy: min(3, digits.distance(from: index, to: digits.endIndex)))
            formattedNumber += digits[index..<endIndex]
            index = endIndex
            if index < digits.endIndex {
                formattedNumber += " "
            }
        }

        return formattedNumber
    }

}

struct PhoneNumberField_Previews: PreviewProvider {
    static var previews: some View {
        let phoneNumber = Binding.constant("123456789012")
        
        return Group {
            // Preview with placeholder text
            PhoneNumberField("Phone Number", phoneNumber: phoneNumber, onEditingChanged: { isInFocus in
                print("Is in focus: \(isInFocus)")
            }, onCommit: {
                print("Committed")
            })
            .padding()
            
            // Preview with initial value
            PhoneNumberField("Phone Number", phoneNumber: phoneNumber, onEditingChanged: { isInFocus in
                print("Is in focus: \(isInFocus)")
            }, onCommit: {
                print("Committed")
            })
            .padding()
            .onAppear {
                phoneNumber.wrappedValue = "987654321012"
            }
        }
    }
}
