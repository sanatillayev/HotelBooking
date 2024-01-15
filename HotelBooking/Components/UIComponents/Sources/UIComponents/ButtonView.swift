//
//  ButtonView.swift
//
//
//  Created by Bilol Sanatillayev on 06/01/24.
//
import SwiftUI

private enum Constants {
    static let font = Font.system(size: 16, weight: .medium)
    static let cornerRadius: CGFloat = 15.0
    static let height: CGFloat = 48.0
    static let color: Color = Color.AppColors.clBlue
    static let hOffset: CGFloat = 16
    static let topOffset: CGFloat = 12

}

public struct ButtonView: View {

    private let title: String
    private let showDivider: Bool
    private let action: () -> Void

    public init(
        title: String,
        showDivider: Bool = false,
        continueAction: @escaping () -> Void
    ) {
        self.title = title
        self.showDivider = showDivider
        self.action = continueAction
    }
    
    @ViewBuilder
    private var background: some View {
        Color.AppColors.clBlue
    }
    

    public var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            if showDivider {
                Divider()
            }

            buttonView
                .padding(.horizontal, Constants.hOffset)
                .padding(.top, showDivider ? Constants.topOffset : 0)
        }
        .background(Color.white)
    }
    
    private var buttonView: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(Constants.font)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.height)
                .background {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill(Constants.color)
                }
        }
    }
}
