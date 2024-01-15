//
//  TouristInfoView.swift
//
//
//  Created by Bilol Sanatillayev on 10/01/24.
//

import SwiftUI
import Models
import UIComponents

private enum Constants {
    static let font = Font.system(size: 22, weight: .medium)
    static let size = CGSize(width: 32, height: 32)
    
    enum Text {
        static let name = "Имя"
        static let surname = "Фамилия"
        static let birthDate = "Дата рождения"
        static let citizenship = "Гражданство"
        static let idNum = "Номер загранпаспорта"
        static let expiryDate = "Срок действия загранпаспорта"
    }
    
}

public struct TouristInfoView: View {
    @State var isShown: Bool
    var title: String
    @Binding var tourist: Tourist

    
    public init(title: String,
                isShown: Bool = true,
                tourist: Binding<Tourist>) {
            self.title = title
            self._isShown = State(initialValue: isShown)
            self._tourist = tourist
    }
    
    public var body: some View {
        DisclosureGroup(isExpanded: $isShown) {
            contentView
        } label: {
            HStack(spacing: .zero) {
                Text(title)
                    .font(Constants.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.AppColors.clLabelPrimary)
                Image(systemName: isShown ? "chevron.up" : "chevron.down")
                    .foregroundStyle(Color.AppColors.clBlue)
                    .frame(width: Constants.size.width, height: Constants.size.height)
                    .background(Color.AppColors.clBlueSecondary)
                    .cornerRadius(6)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isShown.toggle()
                        }
                    }
            }
            .padding(.leading, 16)
            .padding(.vertical, 8)
        }
        .background(.white)
        .cornerRadius(12)
    }
    
    private var nameBinding: Binding<String> {
        Binding(
            get: { tourist.name ?? "" },
            set: { tourist.name = $0 }
        )
    }
    
    private var surnameBinding: Binding<String> {
        Binding(
            get: { tourist.surname ?? "" },
            set: { tourist.surname = $0 }
        )
    }
    
    private var birthdayBinding: Binding<String> {
        Binding(
            get: { tourist.birthday ?? "" },
            set: { tourist.birthday = $0 }
        )
    }
    
    private var citizenshipBinding: Binding<String> {
        Binding(
            get: { tourist.citizenship ?? "" },
            set: { tourist.citizenship = $0 }
        )
    }
    
    private var idNumberBinding: Binding<String> {
        Binding(
            get: { tourist.idNumber ?? "" },
            set: { tourist.idNumber = $0 }
        )
    }
    
    private var expiryDateBinding: Binding<String> {
        Binding(
            get: { tourist.expiryDate ?? "" },
            set: { tourist.expiryDate = $0 }
        )
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            FieldView(title: Constants.Text.name, text: nameBinding)
            FieldView(title: Constants.Text.surname, text: surnameBinding)
            FieldView(title: Constants.Text.birthDate, text: birthdayBinding, isDateField: true)
            FieldView(title: Constants.Text.citizenship, text: citizenshipBinding)
            FieldView(title: Constants.Text.idNum, text: idNumberBinding)
            FieldView(title: Constants.Text.expiryDate, text: expiryDateBinding, isDateField: true)
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(12)
    }
}
