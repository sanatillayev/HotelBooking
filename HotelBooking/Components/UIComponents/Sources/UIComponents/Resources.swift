//
//  UIColors.swift
//
//
//  Created by Bilol Sanatillayev on 04/01/24.
//

import SwiftUI

private enum Constants {
    enum Rate {
        static let star: CGSize = CGSize(width: 15, height: 15)
        static let spacing: CGFloat = 2
        static let font = Font.system(size: 16, weight: .medium)
        static let color: Color = Color.AppColors.clYellow
        static let backgroundColor: Color = Color.AppColors.clYellowSecondary
    }
}

public extension Color {
    
    enum AppColors {
        public static let clLabelPrimary = Color("clLabelPrimary")
        public static let clLabelSecondary = Color("clLabelSecondary")
        public static let clLabelTertiary = Color("clLabelTertiary")

        public static let clBlue = Color("clBlue")
        public static let clBlueSecondary = Color("clBlueSecondary")
        
        public static let clYellow = Color("clYellow")
        public static let clYellowSecondary = Color("clYellowSecondary")

        public static let clBackgroundPrimary = Color("clBackgroundPrimary")
        public static let clBackgroundSecondary = Color("clBackgroundSecondary")
        
    }
}

public extension String {
    
    enum AppIcons {
        // MARK: About Hotel Icons
        public static let icAbout = "icAbout"
        public static let icIncluded = "icIncluded"
        public static let icNotIncluded = "icNotIncluded"
        public static let icDone = "icDone"

    }
}

public func formatPrice(_ number: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.groupingSeparator = " "
    numberFormatter.usesGroupingSeparator = true

    let formattedString = numberFormatter.string(from: NSNumber(value: number)) ?? ""

    return formattedString
}

@ViewBuilder
public func ratingView(_ text: String ,_ rate: Int) -> some View {
    HStack(spacing: 2,content: {
        Image(systemName: "star.fill")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.Rate.star.width,
                   height: Constants.Rate.star.height)
            
        Text("\(rate)")
            .font(Constants.Rate.font)
        Text(text)
            .font(Constants.Rate.font)
    })
    .foregroundStyle(Constants.Rate.color)
    .padding(.horizontal, 10)
    .padding(.vertical, 5)
    .background {
        Constants.Rate.backgroundColor
    }
    .cornerRadius(5)
}
