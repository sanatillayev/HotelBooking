//
//  FieldView.swift
//
//
//  Created by Bilol Sanatillayev on 07/01/24.
//

import SwiftUI
import Combine

private enum Constants {
    static let vSpacing: CGFloat = 8.0
    static let titleFont = Font.system(size: 12.0, weight: .regular)
    static let fieldFont = Font.system(size: 16.0, weight: .regular)
    static let cornerRadius: CGFloat = 10.0
    static let hOffset: CGFloat = 16.0
    static let fieldHeight: CGFloat = 52
    static let textVPadding: CGFloat = 10.0
}

public struct FieldView<Trailing>: View where Trailing: View {

    private let title: String
    private let caption: String?
    private let trailingContent: (() -> Trailing)?
    @Binding var text: String
    @State var isTapped: Bool = false
    private var isDateField: Bool

    public init(
        title: String,
        text: Binding<String>,
        caption: String? = nil,
        isDateField: Bool = false
    ) where Trailing == EmptyView {
        self.title = title
        self._text = text
        self.caption = caption
        self.trailingContent = nil
        self.isDateField = isDateField
    }
    
    public init(
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        caption: String? = nil,
        isDateField: Bool = false,
        @ViewBuilder trailingContent: @escaping () -> Trailing
    ) {
        self.title = title
        self._text = text
        self.caption = caption
        self.isDateField = isDateField
        self.trailingContent = trailingContent
    }
    
    private var textLimit: Int = 42

    public var body: some View {
        VStack(alignment: .leading, spacing: Constants.vSpacing) {
            textField
                .padding(.horizontal, Constants.hOffset)
                .padding(.bottom, isTapped ? Constants.textVPadding : 0 )
                .frame(height: Constants.fieldHeight)
                .background(Color.AppColors.clBackgroundPrimary)
                .cornerRadius(Constants.cornerRadius)

            if let caption {
                Text(caption)
                    .font(Constants.titleFont)
                    .foregroundColor(Color.AppColors.clLabelSecondary)
            }
        }
    }
    
    var textField: some View {
        TextField("", text: $text, onEditingChanged: { isEditing in
            if isEditing {
                withAnimation(.easeIn) {
                    if !text.isEmpty{
                        print("text is not Empty")
                    }
                    print("text is Editing")

                    isTapped = true
                }
            } else {
                withAnimation(.easeOut) {
                    if text.isEmpty {
                        isTapped = false
                    }
                }
            }
        })
        .padding(.top, isTapped ? 24 : 0)
        .background(alignment: .leading, content: {
            Text(title)
                .font(isTapped ? Constants.titleFont : Constants.fieldFont)
                .offset(x: 0, y: isTapped ? -4 : 0)
                .foregroundColor(Color.AppColors.clLabelTertiary)
        })
        .onReceive(Just(text)) { newValue in
            if isDateField {
                text = formatDateString(newValue)
            }
        }
        .keyboardType(isDateField ? .numberPad : .alphabet)
    }
    
    private func formatDateString(_ dateString: String) -> String {
        var formattedString = ""
        for (index, char) in dateString.enumerated() {
            switch index {
            case 2, 5:
                formattedString += "/\(char)"
            default:
                formattedString.append(char)
            }
        }
        return formattedString
    }
    
    private var limitedTextBinding: Binding<String> {
        Binding {
            self.text
        } set: { newText in
            if newText.count <= textLimit {
                self.text = newText
            }
        }
    }
    
}
