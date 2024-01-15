//
//  HotelView.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Models
import Router
import UIComponents

private enum Constants {
    static let title: String = "Отель"
    static let hOffset: CGFloat = 16
    static let cornerRadius: CGFloat = 15
    static let vSpacing: CGFloat = 16
    static let backgroundColor = Color.AppColors.clBackgroundPrimary
    static let buttonTitle = "К выбору номера"

    enum Image {
        static let height: CGFloat = 257
    }
    
    
    enum MainInfo {
        static let fontName = Font.system(size: 22, weight: .medium)
        static let fontAdress = Font.system(size: 14, weight: .medium)
        static let addressColor = Color.AppColors.clBlue
        static let fontPrice = Font.system(size: 30, weight: .semibold)
        static let fontPriceForIt = Font.system(size: 16, weight: .regular)
        static let priceForItColor = Color.AppColors.clLabelSecondary
    }
    enum AboutHotel {
        static let title = "Об отеле"
        static let fontTitle = Font.system(size: 22, weight: .medium)
        static let fontDescription = Font.system(size: 16, weight: .regular)
        static let icon1 = String.AppIcons.icAbout
        static let icon2 = String.AppIcons.icIncluded
        static let icon3 = String.AppIcons.icNotIncluded
        static let primary = Color.AppColors.clLabelPrimary
        static let secondary = Color.AppColors.clLabelSecondary
        static let backgroundColor = Color.AppColors.clBackgroundSecondary
        static let fontButtonTitle = Font.system(size: 16, weight: .medium)
        static let fontButtonSubtitle = Font.system(size: 14, weight: .medium)
        static let title1 = "Удобства"
        static let title2 = "Что включено"
        static let title3 = "Что не включено"
    }
}

public struct HotelView: View {
    
    @StateObject var viewModel: HotelViewModel
    @StateObject var router: HotelRouter

    // MARK: - Routing
    
    private func showRoomsView() {
        if let hotel = viewModel.state.hotel {
            router.showRoomsView(hotel: hotel) {
            }
        }
    }
    
    // MARK: - Life Cycle
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 8) {
                    mainInfoView
                    aboutHotelView
                }
                .background(Constants.backgroundColor)
                .onAppear(perform: {
                    viewModel.action.send(.fetchHotel)
                })
                .padding(.bottom, -8)

            }
            .scrollIndicators(.hidden)
            .navigation(router)
            .safeAreaInset(edge: .top, content: { header })
            .safeAreaInset(edge: .bottom, content: { buttonView })
        }
        .overlay(content: {
            if viewModel.state.isLoading {
                LoadingView()
            }
        })
    }
}



extension HotelView {
    
    private var header: some View {
        HeaderActionView(title: Constants.title)
    }
    
    private var imageView: some View {
        TabView {
            if viewModel.state.isLoading {
                ProgressView()
                    .padding(.horizontal, Constants.hOffset)
            } else {
                ForEach(viewModel.state.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 32)
                        .clipped()
                        .tag(image)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: Constants.Image.height)
        .cornerRadius(Constants.cornerRadius)
    }
    
    private var mainTextInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let hotel = viewModel.state.hotel {
                ratingView(hotel.ratingName, hotel.rating)
            }
            Text(viewModel.state.hotel?.name ?? "")
                .font(Constants.MainInfo.fontName)
            Text(viewModel.state.hotel?.adress ?? "")
                .font(Constants.MainInfo.fontAdress)
                .foregroundStyle(Constants.MainInfo.addressColor)
            HStack(alignment: .bottom, spacing: 8) {
                if let hotel = viewModel.state.hotel {
                    Text("от "+formatPrice(hotel.minimalPrice)+" ₽")
                        .font(Constants.MainInfo.fontPrice)
                    Text(hotel.priceForIt.lowercased())
                        .font(Constants.MainInfo.fontPriceForIt)
                        .foregroundStyle(Constants.MainInfo.priceForItColor)
                        .offset(x:0,y:-3)
                }
            }
            .padding(.bottom, 16)
            .padding(.top, 8)
        }
    }
    
    

    
    private var mainInfoView: some View {
        VStack(alignment: .leading, spacing: Constants.vSpacing) {
            imageView
            mainTextInfoView
        }
        .padding(.horizontal, Constants.hOffset)
        .background(Color.white)
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 12,
                topTrailingRadius: 0
            )
        )
    }
    
    private var aboutHotelView: some View {
        VStack(alignment: .leading, spacing: Constants.vSpacing) {
            Text(Constants.AboutHotel.title)
                .font(Constants.AboutHotel.fontTitle)
            tagsView
            if let hotel = viewModel.state.hotel {
                Text(hotel.aboutTheHotel.description)
                    .font(Constants.AboutHotel.fontDescription)
            }
            threeButtons
        }
        .padding(.all, Constants.hOffset)
        .background(Color.white)
        .clipShape(
            .rect(
                topLeadingRadius: 12,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 12,
                topTrailingRadius: 12
            )
        )
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    private var tagsView: some View {
        if let hotel = viewModel.state.hotel {
            TagsView(data: hotel.aboutTheHotel.peculiarities, id: \.self) { text in
                InfoTag(text: text)
            }
        }
    }
    
    private var threeButtons: some View {
        VStack(alignment: .leading, spacing: .zero) {
            
            rowButton(title: Constants.AboutHotel.title1, icon: Constants.AboutHotel.icon1) {
                // TODO: action is here
            }
            Divider()
                .padding(.leading, 38)
            rowButton(title: Constants.AboutHotel.title2, icon: Constants.AboutHotel.icon2) {
                // TODO: action is here
            }
            Divider()
                .padding(.leading, 38)
            rowButton(title: Constants.AboutHotel.title3, icon: Constants.AboutHotel.icon3) {
                // TODO: action is here
            }
        }
        .padding(.all, 5)
        .background(Constants.AboutHotel.backgroundColor)
        .cornerRadius(Constants.cornerRadius)
    }
    
    private func rowButton(title: String,icon: String,action: @escaping() -> Void) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(icon)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(Constants.AboutHotel.fontButtonTitle)
                    .foregroundStyle(Constants.AboutHotel.primary)
                Text("Самое необходимое")
                    .font(Constants.AboutHotel.fontButtonSubtitle)
                    .foregroundStyle(Constants.AboutHotel.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "chevron.right")
                .padding(.trailing, 5)
        }
        .padding(.all, 10)
    }
    
    private var buttonView: some View {
        ButtonView(title: Constants.buttonTitle, showDivider: true) {
            showRoomsView()
        }
    }

    
    
}

// MARK: - Formatter
extension HotelView {
    
}
