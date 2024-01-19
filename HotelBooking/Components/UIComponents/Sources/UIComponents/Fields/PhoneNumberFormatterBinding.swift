//
//  File.swift
//  
//
//  Created by Bilol Sanatillayev on 19/01/24.
//

import SwiftUI

public struct PhoneNumberFormatterBinding {
    public var text: String = ""
    public init() {
    }
    public mutating func set(newValue: String) {
        let filteredValue = newValue.filter { "0123456789".contains($0) }
        text = PhoneNumberFormatter.format(filteredValue)
    }
}

public struct PhoneNumberFormatter {
    static func format(_ phoneNumber: String) -> String {
        var formattedNumber = ""
            var index = phoneNumber.startIndex
                
            // Add country code
            formattedNumber.append("+7")
                
            // Add digits
            while index < phoneNumber.endIndex {
                if index == phoneNumber.index(phoneNumber.startIndex, offsetBy: 1) {
                    formattedNumber.append("(")
                } else if index == phoneNumber.index(phoneNumber.startIndex, offsetBy: 4) {
                    formattedNumber.append(") ")
                } else if index == phoneNumber.index(phoneNumber.startIndex, offsetBy: 7) {
                    formattedNumber.append("-")
                }
                formattedNumber.append(phoneNumber[index])
                index = phoneNumber.index(after: index)
            }
            return formattedNumber
    }
}
