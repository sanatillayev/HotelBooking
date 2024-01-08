//
//  SwiftUIView.swift
//  
//
//  Created by Bilol Sanatillayev on 06/01/24.
//

import SwiftUI

public struct TagsView<Content, Data, ID>: View
    where Content : View, Data: RandomAccessCollection, ID: Hashable {
    
    var data: Data
    let id: KeyPath<Data.Element, ID>
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let content: (Data.Element) -> Content
    @State private var totalHeight: CGFloat = .zero
    
    public init(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        verticalSpacing: CGFloat = 8,
        horizontalSpacing: CGFloat = 8,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
        self.content = content
    }
    
    private var itemVerticalPadding: CGFloat {
        verticalSpacing / 2
    }
    
    private var itemHorizontalPadding: CGFloat {
        horizontalSpacing / 2
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
                    .background(viewHeightReader($totalHeight))
            }
        }
        .frame(height: totalHeight)
        .padding(.vertical, -itemVerticalPadding)
        .padding(.horizontal, -itemHorizontalPadding)
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.data, id: id) { item in
                let tag = item[keyPath: self.id]
                self.content(item)
                    .padding(.vertical, itemVerticalPadding)
                    .padding(.horizontal, itemHorizontalPadding)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = .zero
                            height -= dimension.height
                        }
                        let result = width
                        if let lastTag = self.data.last,
                           tag == lastTag[keyPath: self.id] {
                            width = .zero // last item
                        } else {
                            width -= dimension.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if let lastTag = self.data.last,
                           tag == lastTag[keyPath: self.id] {
                            height = .zero // last item
                        }
                        return result
                    }
            }
        }
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
