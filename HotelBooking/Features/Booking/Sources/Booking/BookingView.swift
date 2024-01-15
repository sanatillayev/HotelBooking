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
    }
}

extension BookingView {
    
    private var header: some View {
        HeaderActionView(title: Constants.title) {
            closeView()
        }
    }
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
            FieldView(title: "Hомер телефона", text: phoneNumberBinding)
            FieldView(title: "Почта", 
                      text: emailBinding,
                      caption: "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(12)
    }
    private var allTouristInfoView: some View {
        VStack(alignment: .center, spacing: 8){
            ForEach(viewModel.state.tourists.indices, id: \.self) { index in
                touristInfoView(for: index)
            }
        }
    }
    @ViewBuilder
    private func touristInfoView(for index: Int) -> some View {
        if let binding = viewModel.state.touristBindings[index] {
            TouristInfoView(title: "\(index+1)-турист", tourist: binding)
        }
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
        ButtonView(title: "Оплатить \( formatPrice(viewModel.state.totalPrice) ) ₽",
                   showDivider: true) {
            showMadePaymentView()
        }
    }
}

extension BookingView {
    var phoneNumberBinding: Binding<String> {
        Binding {
            viewModel.state.phoneNumber
        } set: { newValue in
            viewModel.action.send(.setPhoneNumber(newValue))
        }
    }
    var emailBinding: Binding<String> {
        Binding {
            viewModel.state.email
        } set: { newValue in
            viewModel.action.send(.setEmail(newValue))
        }
    }
}
