//
//  RoomsView.swift
//  HotelBooking
//
//  Created by Bilol Sanatillayev on 02/01/24.
//

import SwiftUI
import Models
import Router
import UIComponents

private enum Constants {
    static let title: String = "title"
    static let cornerRadius: CGFloat = 15
    static let vSpacing: CGFloat = 16
    static let hOffset: CGFloat = 16
    static let clBackground = Color.AppColors.clBackgroundPrimary
    
    enum MainInfo {
        static let fontName = Font.system(size: 22, weight: .medium)
        static let fontAdress = Font.system(size: 14, weight: .medium)
        static let blue = Color.AppColors.clBlue
        static let fontPrice = Font.system(size: 30, weight: .semibold)
        static let fontPriceForIt = Font.system(size: 16, weight: .regular)
        static let secondaryLabel = Color.AppColors.clLabelSecondary
    }

    enum Image {
        static let height: CGFloat = 257
    }
    
    enum Button {
        static let title = "Выбрать номер"
    }
    enum SmallButton {
        static let title = "Подробнее о номере"
        static let font = Font.system(size: 16, weight: .medium)
        static let color = Color.AppColors.clBlue
        static let bgColor = Color.AppColors.clBlueSecondary
        static let height: CGFloat = 29
        static let hSpacing: CGFloat = 5
        static let vSpacing: CGFloat = 10
    }
}


public struct RoomsView: View {
    
    @StateObject var router: RoomsRouter
    @StateObject var viewModel: RoomsViewModel

    init(router: RoomsRouter, viewModel: RoomsViewModel) {
        self._router = StateObject(wrappedValue: router)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    // MARK: - Routing
    
    private func showBookingView() {
        router.showBookingView()
    }
    
//    private func showMadePaymentView() {
//        router.showMadePayment()
//    }
    
    private func closeView() {
        router.closeView()
    }

    // MARK: - Life cycle

    public var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.state.rooms, id: \.self) { room in
                    roomCard(room)
                }
            }
        }
        .background(Constants.clBackground)
        .onAppear(perform: {
            viewModel.action.send(.fetchRooms)
        })
        .navigation(router)
        .safeAreaInset(edge: .top, content: { header })
        .toolbar(.hidden, for: .navigationBar)
        .scrollIndicators(.hidden)
        .overlay {
            if viewModel.state.isLoading {
                LoadingView()
            }
        }
    }
}

extension RoomsView {
    
    private var header: some View {
        HeaderActionView(title: viewModel.state.hotel.name) {
            closeView()
        }
    }
    
    private func imageView(_ images: [UIImage]) -> some View {
        TabView {
            if viewModel.state.isLoading {
                ProgressView()
                    .padding(.horizontal, Constants.hOffset)
                    .frame(width: UIScreen.main.bounds.width - 32)

            } else {
                ForEach(images, id: \.self) { image in
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
    
    private func roomCard(_ room: Room) -> some View {
        VStack(alignment: .leading, spacing: 8){
            if let images = viewModel.state.roomImages[room.id] {
                imageView(images)
            }
            Text(room.name)
                .font(Constants.MainInfo.fontName)

            tagsView(room)
            smallButton
            
            HStack(alignment: .bottom, spacing: 8) {
                Text(formatPrice(room.price)+" ₽")
                    .font(Constants.MainInfo.fontPrice)
                Text(room.pricePer.lowercased())
                    .font(Constants.MainInfo.fontPriceForIt)
                    .foregroundStyle(Constants.MainInfo.secondaryLabel)
                    .offset(x:0,y:-3)
            }
            .padding(.vertical, 8)
            
            ButtonView(title: Constants.Button.title) {
                showBookingView()
                // TODO: add action to go booking view
                
//                showMadePaymentView()
            }
            .padding(.horizontal, -Constants.hOffset)

        }
        .padding(.all, Constants.hOffset)
        .background(Color.white)
        .cornerRadius(12)
    }
    
    private func tagsView(_ room: Room) -> some View {
        TagsView(data: room.peculiarities, id: \.self) { text in
            InfoTag(text: text)
        }
    }
    
    private var smallButton: some View {
        HStack(alignment: .center, spacing: 8, content: {
            Text(Constants.SmallButton.title)
                .font(Constants.SmallButton.font)
                .kerning(-0.6)
                .padding(.leading, 5)

            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
        })
        .foregroundStyle(Constants.SmallButton.color)
        .padding(.horizontal, Constants.SmallButton.hSpacing)
        .frame(height: Constants.SmallButton.height)
        .background(Constants.SmallButton.bgColor)
        .cornerRadius(5)
    }
}
