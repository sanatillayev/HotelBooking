//
//  File.swift
//  
//
//  Created by Bilol Sanatillayev on 06/01/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 8.0
    static let font = Font.system(size: 16.0)
}

public struct LoadingView: View {

    let color: Color

    public init(color: Color = .AppColors.clBlueSecondary) {
        self.color = color
    }

    public var body: some View {
        HStack(spacing: Constants.spacing) {
            ProgressView()
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity)
    }
}
