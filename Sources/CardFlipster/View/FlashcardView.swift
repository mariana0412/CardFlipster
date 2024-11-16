//
//  FlashcardView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 15.11.2024.
//

import SwiftUI

public struct FlashcardView: View {

    private enum Constants {
        static let cardWidth: CGFloat = 300
        static let cardHeight: CGFloat = 450
        static let cornerRadius: CGFloat = 10
        static let minScaleFactor: CGFloat = 0.8
    }

    @Binding var isFlipped: Bool

    let frontText: String
    let backText: String
    let frontColor: Color
    let backColor: Color
    let font: Font
    let frontFontColor: Color
    let backFontColor: Color
    let axis: Axis
    let animationDuration: TimeInterval

    public var body: some View {
        VStack {
            cardView
        }
    }

    private var cardView: some View {
        flashcard
            .id(isFlipped)
            .transition(.flip(side: isFlipped ? .back : .front,
                              axis: axis,
                              animationDuration: animationDuration))
            .onTapGesture {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    isFlipped.toggle()
                }
            }
    }

    private var flashcard: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(isFlipped ? backColor : frontColor)
            .overlay(contentOverlay)
            .frame(width: Constants.cardWidth, height: Constants.cardHeight)
    }

    private var contentOverlay: some View {
        Text(isFlipped ? backText : frontText)
            .font(font)
            .foregroundColor(isFlipped ? backFontColor : frontFontColor)
            .padding()
            .minimumScaleFactor(Constants.minScaleFactor)
    }
}

struct FlashcardViewPreview: View {
    @State private var isFlipped = false

    var body: some View {
        FlashcardView(
            isFlipped: $isFlipped,
            frontText: "Hello, World!",
            backText: "Goodbye, World!",
            frontColor: .blue,
            backColor: .yellow,
            font: .largeTitle,
            frontFontColor: .white,
            backFontColor: .black,
            axis: .horizontal,
            animationDuration: 0.8
        )
    }
}
#Preview {
    FlashcardViewPreview()
}
