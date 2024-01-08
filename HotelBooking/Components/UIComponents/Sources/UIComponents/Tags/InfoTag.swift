//
//  SwiftUIView.swift
//  
//
//  Created by Bilol Sanatillayev on 06/01/24.
//

import SwiftUI

import SwiftUI

private enum Constants {
    static let font = Font.system(size: 16.0, weight: .medium)
    static let textColor = Color.AppColors.clLabelSecondary
    static let lineLimit: Int = 1
    
    static let horizontalPadding: CGFloat = 10.0
    static let verticalPadding: CGFloat = 5.0
    static let cornerRadius: CGFloat = 5
    static let color = Color.AppColors.clBackgroundSecondary
}
 
public struct InfoTag: View {
    let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .kerning(-0.5)
            .font(Constants.font)
            .foregroundColor(Constants.textColor)
            .lineLimit(Constants.lineLimit)
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background(Constants.color)
            .cornerRadius(Constants.cornerRadius)
    }
}
