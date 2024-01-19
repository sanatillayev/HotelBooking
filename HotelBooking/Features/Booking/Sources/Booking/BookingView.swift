//
//  BookingView.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import UIComponents
import Router
import Models
import Combine

private enum Constants {
    
    static let title: String = "Бронирование"
    static let spacing: CGFloat = 16
    static let clBackground = Color.AppColors.clBackgroundPrimary
    
    enum MainInfo {
        static let fontName = Font.system(size: 22, weight: .medium)
        static let fontAdress = Font.system(size: 14, weight: .medium)
        static let addressColor = Color.AppColors.clBlue
        static let fontPrice = Font.system(size: 30, weight: .semibold)
        static let fontPriceForIt = Font.system(size: 16, weight: .regular)
        static let priceForItColor = Color.AppColors.clLabelSecondary
    }
    
    enum Text {
        static let departure = "Вылет из"
        static let arrival = "Страна, город"
        static let date = "Даты"
        static let numOfNights = "Кол-во ночей"
        static let hotel = "Отель"
        static let room = "Номер"
        static let nutrition = "Питание"
        static let infoAboutCustomer = "Информация о покупателе"
        static let phoneNum = "Номер телефона"
        static let mail = "Почта"
        static let caption = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
        static let firstTourist = "Первый турист"
        static let secondTourist = "Второй турист"
        static let addTourist = "Добавить туриста"
        static let tour = "Тур"
        static let fuel = "Топливный сбор"
        static let service = "Сервисный сбор"
        static let total = "К оплате"
        static let pay = "Оплатить"
        static let font = Font.system(size: 16, weight: .regular)
        static let clTitle = Color.AppColors.clLabelSecondary
        static let clInfo = Color.AppColors.clLabelPrimary
    }
    
    enum Checkout{
        static let tourFee = "Тур"
        static let fuelFee = "Топливный сбор"
        static let serviceFee = "Сервисный сбор"
        static let payTotal = "К оплате"
        static let font = Font.system(size: 16, weight: .regular)
        static let clTitle = Color.AppColors.clLabelSecondary
        static let clInfo = Color.AppColors.clLabelPrimary

    }
}

public struct BookingView: View {
    
    @StateObject var viewModel: BookingViewModel
    @StateObject var router: BookingRouter
    
    // MARK: - Routing
    
    func closeView() {
        router.dismiss()
    }
    
    private func showMadePaymentView() {
        router.showMadePayment()
    }
    private var isButtonDisable: Bool {
        viewModel.state.phoneNumber.isEmpty || viewModel.state.email.isEmpty
        // TODO: other properties
    }
    
    // MARK: - Life Cycle
    public var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                mainTextInfoView
                tourInfoView
                infoAboutCustomerView
                allTouristInfoView
                addTouristButtonView
                totalPriceView
            }
            .onTapGesture(perform: hideKeyboard)
        }
        .background(Constants.clBackground)
        .onAppear(perform: {
            viewModel.action.send(.fetchTour)
            viewModel.action.send(.addFirstTourist)
        })
        .navigation(router)
        .safeAreaInset(edge: .top, content: { header } )
        .safeAreaInset(edge: .bottom, content: { buttonView } )
        .toolbar(.hidden, for: .navigationBar)
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .overlay(content: {
            if viewModel.state.isLoading {
                LoadingView()
            }
        })
    }
}

extension BookingView {
    
    private var header: some View {
        HeaderActionView(title: Constants.title) {
            closeView()
        }
    }
    @ViewBuilder
    private var mainTextInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let tour = viewModel.state.tour {
                ratingView(tour.ratingName, tour.horating)
                Text(tour.hotelName)
                    .font(Constants.MainInfo.fontName)
                Text(tour.hotelAdress)
                    .font(Constants.MainInfo.fontAdress)
                    .foregroundStyle(Constants.MainInfo.addressColor)
            }
        }
        .padding(.all, Constants.spacing)
        .background(Color.white)
        .cornerRadius(15.0)
    }
    
    @ViewBuilder
    private var tourInfoView: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            if let tour = viewModel.state.tour {
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.departure)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text(tour.departure)
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.arrival)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text(tour.arrivalCountry)
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.date)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text(tour.tourDateStart + "-" + tour.tourDateStop)
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.numOfNights)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text("\(tour.numberOfNights)" + " ночей")
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.hotel)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text(tour.hotelName)
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.room)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text(tour.room)
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment:.top ,spacing: .zero) {
                    Text(Constants.Text.nutrition)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Text(tour.nutrition)
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
            }
        }
        .padding(.all, Constants.spacing)
        .background(Color.white)
        .cornerRadius(15.0)
    }
    private var infoAboutCustomerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Информация о покупателе")
                .font(Constants.MainInfo.fontName)
            PhoneNumberFieldView(title: "Hомер телефона", text: phoneNumberBinding)
            FieldView(title: "Почта",
                      text: emailBinding,
                      caption: "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
            .keyboardType(.emailAddress)
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(12)
    }
    @ViewBuilder
    private var allTouristInfoView: some View {
        VStack(alignment: .center, spacing: 8){
            firstTouristInfoView
            if viewModel.state.tourists.count >= 2 {
                secondTouristInfoView
            }
            if viewModel.state.tourists.count >= 3 {
                thirdTouristInfoView
            }
            if viewModel.state.tourists.count >= 4 {
                fourthTouristInfoView
            }
            if viewModel.state.tourists.count >= 5 {
                fifthTouristInfoView
            }
        }
    }

    private var firstTouristInfoView: some View {
        TouristInfoView(isShown: true,
                        title: .first,
                        name: nameBinding,
                        surname: surnameBinding,
                        birthday: birthdayBinding,
                        citizenship: citizenshipBinding,
                        idNumber: idNumberBinding,
                        expiryDate: expiryDateBinding)
    }
    
    private var secondTouristInfoView: some View {
        TouristInfoView(isShown: false,
                        title: .second,
                        name: secondNameBinding,
                        surname: secondSurnameBinding,
                        birthday: secondBirthdayBinding,
                        citizenship: secondCitizenshipBinding,
                        idNumber: secondIdNumberBinding,
                        expiryDate: secondExpiryDateBinding)
    }
    private var thirdTouristInfoView: some View {
        TouristInfoView(isShown: false,
                        title: .third,
                        name: thirdNameBinding,
                        surname: thirdSurnameBinding,
                        birthday: thirdBirthdayBinding,
                        citizenship: thirdCitizenshipBinding,
                        idNumber: thirdIdNumberBinding,
                        expiryDate: thirdExpiryDateBinding)
    }

    private var fourthTouristInfoView: some View {
        TouristInfoView(isShown: false,
                        title: .fourth,
                        name: fourthNameBinding,
                        surname: fourthSurnameBinding,
                        birthday: fourthBirthdayBinding,
                        citizenship: fourthCitizenshipBinding,
                        idNumber: fourthIdNumberBinding,
                        expiryDate: fourthExpiryDateBinding)
    }

    private var fifthTouristInfoView: some View {
        TouristInfoView(isShown: false,
                        title: .fifth,
                        name: fifthNameBinding,
                        surname: fifthSurnameBinding,
                        birthday: fifthBirthdayBinding,
                        citizenship: fifthCitizenshipBinding,
                        idNumber: fifthIdNumberBinding,
                        expiryDate: fifthExpiryDateBinding)
    }

    
    private var addTouristButtonView: some View {
        HStack(spacing: .zero){
            Text("Добавить туриста")
                .font(Constants.MainInfo.fontName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.AppColors.clLabelPrimary)
            Button(action: {
                viewModel.action.send(.addTourist)
            }) {
                Image(systemName:  "plus" )
                    .foregroundStyle(Color.white)
                    .frame(width: 32, height: 32)
                    .background(Color.AppColors.clBlue)
                    .cornerRadius(6)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(Color.white)
        .cornerRadius(12)
    }
    private var totalPriceView: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let tour = viewModel.state.tour {
                HStack(alignment: .center, spacing: .zero) {
                    Text(Constants.Checkout.tourFee)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Spacer()
                    Text(formatPrice(tour.tourPrice) + " ₽")
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment: .center, spacing: .zero) {
                    Text(Constants.Checkout.fuelFee)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Spacer()
                    Text(formatPrice(tour.fuelCharge) + " ₽")
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment: .center, spacing: .zero) {
                    Text(Constants.Checkout.serviceFee)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Spacer()
                    Text(formatPrice(tour.serviceCharge) + " ₽")
                        .font(Constants.Text.font)
                        .foregroundStyle(Constants.Text.clInfo)
                }
                HStack(alignment: .center, spacing: .zero) {
                    Text(Constants.Checkout.payTotal)
                        .font(Constants.Text.font)
                        .frame(width: 140, alignment: .leading)
                        .foregroundStyle(Constants.Text.clTitle)
                    Spacer()
                    Text(formatPrice(viewModel.state.totalPrice) + " ₽")
                        .font(Constants.Text.font)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.AppColors.clBlue)
                }
            }
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(12)
        .onAppear { viewModel.action.send(.findTotalPrice) }
    }
    private var buttonView: some View {
        ButtonView(title: "Оплатить \(formatPrice(viewModel.state.totalPrice)) ₽",
                   showDivider: true, 
                   isButtonDisabled: viewModel.state.isSuperButtonDisabled) {
            showMadePaymentView()
        }
        .disabled(viewModel.state.isSuperButtonDisabled)
                   
    }
}

extension BookingView {
    private var phoneNumberBinding: Binding<String> {
        Binding {
            viewModel.state.phoneNumber
        } set: { newValue in
            viewModel.action.send(.setPhoneNumber(newValue))
        }
    }

    private var emailBinding: Binding<String> {
        Binding {
            viewModel.state.email
        } set: { newValue in
            viewModel.action.send(.setEmail(newValue))
        }
    }
    
    // MARK: - First Tourist bindings
    private var nameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.firstTourist.name ?? "" },
            set: { newValue in
                viewModel.action.send(.setName(newValue))
            }
        )
    }
    
    private var surnameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.firstTourist.surname ?? "" },
            set: { newValue in
                viewModel.action.send(.setSurname(newValue))
            }
        )
    }
    
    private var birthdayBinding: Binding<String> {
        Binding(
            get: { viewModel.state.firstTourist.birthday ?? "" },
            set: { newValue in
                viewModel.action.send(.setBirthdate(newValue))
            }
        )
    }
    
    private var citizenshipBinding: Binding<String> {
        Binding(
            get: { viewModel.state.firstTourist.citizenship ?? "" },
            set: { newValue in
                viewModel.action.send(.setCitizenship(newValue))
            }
        )
    }
    
    private var idNumberBinding: Binding<String> {
        Binding(
            get: { viewModel.state.firstTourist.idNumber ?? "" },
            set: { newValue in
                viewModel.action.send(.setIdNumber(newValue))
            }
        )
    }
    
    private var expiryDateBinding: Binding<String> {
        Binding(
            get: { viewModel.state.firstTourist.expiryDate ?? "" },
            set: { newValue in
                viewModel.action.send(.setExpiryDate(newValue))
            }
        )
    }
    
    // MARK: - Second Tourist bindings

    private var secondNameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.secondTourist.name ?? "" },
            set: { newValue in
                viewModel.action.send(.setSecondName(newValue))
            }
        )
    }

    private var secondSurnameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.secondTourist.surname ?? "" },
            set: { newValue in
                viewModel.action.send(.setSecondSurname(newValue))
            }
        )
    }

    private var secondBirthdayBinding: Binding<String> {
        Binding(
            get: { viewModel.state.secondTourist.birthday ?? "" },
            set: { newValue in
                viewModel.action.send(.setSecondBirthdate(newValue))
            }
        )
    }

    private var secondCitizenshipBinding: Binding<String> {
        Binding(
            get: { viewModel.state.secondTourist.citizenship ?? "" },
            set: { newValue in
                viewModel.action.send(.setSecondCitizenship(newValue))
            }
        )
    }

    private var secondIdNumberBinding: Binding<String> {
        Binding(
            get: { viewModel.state.secondTourist.idNumber ?? "" },
            set: { newValue in
                viewModel.action.send(.setSecondIdNumber(newValue))
            }
        )
    }

    private var secondExpiryDateBinding: Binding<String> {
        Binding(
            get: { viewModel.state.secondTourist.expiryDate ?? "" },
            set: { newValue in
                viewModel.action.send(.setSecondExpiryDate(newValue))
            }
        )
    }

    // MARK: - Third Tourist bindings

    private var thirdNameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.thirdTourist.name ?? "" },
            set: { newValue in
                viewModel.action.send(.setThirdName(newValue))
            }
        )
    }

    private var thirdSurnameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.thirdTourist.surname ?? "" },
            set: { newValue in
                viewModel.action.send(.setThirdSurname(newValue))
            }
        )
    }

    private var thirdBirthdayBinding: Binding<String> {
        Binding(
            get: { viewModel.state.thirdTourist.birthday ?? "" },
            set: { newValue in
                viewModel.action.send(.setThirdBirthdate(newValue))
            }
        )
    }

    private var thirdCitizenshipBinding: Binding<String> {
        Binding(
            get: { viewModel.state.thirdTourist.citizenship ?? "" },
            set: { newValue in
                viewModel.action.send(.setThirdCitizenship(newValue))
            }
        )
    }

    private var thirdIdNumberBinding: Binding<String> {
        Binding(
            get: { viewModel.state.thirdTourist.idNumber ?? "" },
            set: { newValue in
                viewModel.action.send(.setThirdIdNumber(newValue))
            }
        )
    }

    private var thirdExpiryDateBinding: Binding<String> {
        Binding(
            get: { viewModel.state.thirdTourist.expiryDate ?? "" },
            set: { newValue in
                viewModel.action.send(.setThirdExpiryDate(newValue))
            }
        )
    }
    // MARK: - Fourth Tourist bindings

    private var fourthNameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fourthTourist.name ?? "" },
            set: { newValue in
                viewModel.action.send(.setFourthName(newValue))
            }
        )
    }

    private var fourthSurnameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fourthTourist.surname ?? "" },
            set: { newValue in
                viewModel.action.send(.setFourthSurname(newValue))
            }
        )
    }

    private var fourthBirthdayBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fourthTourist.birthday ?? "" },
            set: { newValue in
                viewModel.action.send(.setFourthBirthdate(newValue))
            }
        )
    }

    private var fourthCitizenshipBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fourthTourist.citizenship ?? "" },
            set: { newValue in
                viewModel.action.send(.setFourthCitizenship(newValue))
            }
        )
    }

    private var fourthIdNumberBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fourthTourist.idNumber ?? "" },
            set: { newValue in
                viewModel.action.send(.setFourthIdNumber(newValue))
            }
        )
    }

    private var fourthExpiryDateBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fourthTourist.expiryDate ?? "" },
            set: { newValue in
                viewModel.action.send(.setFourthExpiryDate(newValue))
            }
        )
    }
    // MARK: - Fifth Tourist bindings

    private var fifthNameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fifthTourist.name ?? "" },
            set: { newValue in
                viewModel.action.send(.setFifthName(newValue))
            }
        )
    }

    private var fifthSurnameBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fifthTourist.surname ?? "" },
            set: { newValue in
                viewModel.action.send(.setFifthSurname(newValue))
            }
        )
    }

    private var fifthBirthdayBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fifthTourist.birthday ?? "" },
            set: { newValue in
                viewModel.action.send(.setFifthBirthdate(newValue))
            }
        )
    }

    private var fifthCitizenshipBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fifthTourist.citizenship ?? "" },
            set: { newValue in
                viewModel.action.send(.setFifthCitizenship(newValue))
            }
        )
    }

    private var fifthIdNumberBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fifthTourist.idNumber ?? "" },
            set: { newValue in
                viewModel.action.send(.setFifthIdNumber(newValue))
            }
        )
    }

    private var fifthExpiryDateBinding: Binding<String> {
        Binding(
            get: { viewModel.state.fifthTourist.expiryDate ?? "" },
            set: { newValue in
                viewModel.action.send(.setFifthExpiryDate(newValue))
            }
        )
    }

}
