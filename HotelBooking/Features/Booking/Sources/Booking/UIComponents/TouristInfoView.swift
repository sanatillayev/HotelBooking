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
    static let red = Color.AppColors.clRed
    
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
    var title: TouristNumber
    @Binding var name: String
    @Binding var surname: String
    @Binding var birthday: String
    @Binding var citizenship: String
    @Binding var idNumber: String
    @Binding var expiryDate: String

    @FocusState private var focusedField: Field?
    
    init(isShown: Bool = false, title: TouristNumber, name: Binding<String>, surname: Binding<String>, birthday: Binding<String>, citizenship: Binding<String>, idNumber: Binding<String>, expiryDate: Binding<String>) {
        self.isShown = isShown
        self.title = title
        self._name = name
        self._surname = surname
        self._birthday = birthday
        self._citizenship = citizenship
        self._idNumber = idNumber
        self._expiryDate = expiryDate
    }
    
    public var body: some View {
        DisclosureGroup(isExpanded: $isShown) {
            contentView
        } label: {
            HStack(spacing: .zero) {
                Text(title.rawValue)
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
    
    @ViewBuilder
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            FieldView(title: Constants.Text.name, text: $name)
                .submitLabel(.continue)
                .focused($focusedField, equals: .name)
            FieldView(title: Constants.Text.surname, text: $surname)
                .submitLabel(.continue)
                .focused($focusedField, equals: .surname)
            FieldView(title: Constants.Text.birthDate, text: $birthday)
                .keyboardType(.numbersAndPunctuation)
                .submitLabel(.continue)
                .focused($focusedField, equals: .birthDate)
            FieldView(title: Constants.Text.citizenship, text: $citizenship)
                .submitLabel(.continue)
                .focused($focusedField, equals: .citizenship)
            FieldView(title: Constants.Text.idNum, text: $idNumber)
                .keyboardType(.default)
                .submitLabel(.continue)
                .focused($focusedField, equals: .idNumber)
            FieldView(title: Constants.Text.expiryDate, text: $expiryDate)
                .keyboardType(.numbersAndPunctuation)
                .submitLabel(.done)
                .focused($focusedField, equals: .expiryDate)
        }
        .onSubmit {
            switch focusedField {
            case .name:
                focusedField = .surname
            case .surname:
                focusedField = .birthDate
            case .birthDate:
                focusedField = .citizenship
            case .citizenship:
                focusedField = .idNumber
            case .idNumber:
                focusedField = .expiryDate
            case .expiryDate:
                focusedField = nil
            default:
                print("done")
            }
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(12)
    }
}

extension TouristInfoView {
    enum Field: String {
        case name, surname, birthDate, citizenship, idNumber, expiryDate
    }
    private func focusNextField() {
            switch focusedField {
            case .name:
                focusedField = .surname
            case .surname:
                focusedField = .birthDate
            case .birthDate:
                focusedField = .citizenship
            case .citizenship:
                focusedField = .idNumber
            case .idNumber:
                focusedField = .expiryDate
            case .expiryDate:
                focusedField = nil
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            default:
                break
            }
        }
}
