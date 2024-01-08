
import SwiftUI

private enum Constants {
    static let contentHeight: CGFloat = 51.0
    static let font = Font.system(size: 18.0, weight: .medium)
    static let vOffset: CGFloat = 9.0
    
    enum Back{
        static let topSpacing: CGFloat = 24
        static let leadSpacing: CGFloat = 24
        static let iconSize = CGSize(width: 16.0, height: 16.0)
        static let color = Color.black
    }
}

public struct HeaderActionView: View {

    private let title: String
    private let goBack: (() -> Void)?

    public init(
        title: String,
        goBack: (() -> Void)? = nil
    ) {
        self.title = title
        self.goBack = goBack
    }

    public var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            backButton
            Spacer()
        }
        .frame(height: Constants.contentHeight, alignment: .center)
        .overlay(alignment: .center) {
            Text(title)
                .font(Constants.font)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .lineLimit(1)
                .padding(.horizontal, 48)
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    private var backButton: some View {
        if let goBack = goBack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Back.iconSize.width, height: Constants.Back.iconSize.height)
                .padding(.leading, Constants.Back.leadSpacing)
                .foregroundColor(Constants.Back.color)
                .onTapGesture(perform: goBack)
        }
    }
}
