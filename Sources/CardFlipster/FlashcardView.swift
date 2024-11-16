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

    @State private var side: FlipTransitionViewModifier.Side = .front

    private var frontText: String = "Front"
    private var backText: String = "Back"
    private var frontColor: Color = .blue
    private var backColor: Color = .yellow
    private var font: Font = .title
    private var frontFontColor: Color = .white
    private var backFontColor: Color = .black
    private var axis: Axis = .horizontal
    private var animationDuration: TimeInterval = 0.6

    public init(
        frontText: String = "Front",
        backText: String = "Back",
        frontColor: Color = .blue,
        backColor: Color = .yellow,
        font: Font = .title,
        frontFontColor: Color = .white,
        backFontColor: Color = .black,
        axis: Axis = .horizontal,
        animationDuration: TimeInterval = 0.6
    ) {
        self.frontText = frontText
        self.backText = backText
        self.frontColor = frontColor
        self.backColor = backColor
        self.font = font
        self.frontFontColor = frontFontColor
        self.backFontColor = backFontColor
        self.axis = axis
        self.animationDuration = animationDuration
    }

    public var body: some View {
        VStack {
            cardView
        }
    }

    private var cardView: some View {
        flashcard
            .id(side)
            .transition(.flip(side: side,
                              axis: axis,
                              animationDuration: animationDuration))
            .onTapGesture {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    side = side == .front ? .back : .front
                }
            }
    }

    private var flashcard: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(side == .back ? backColor : frontColor)
            .overlay(contentOverlay)
            .frame(width: Constants.cardWidth, height: Constants.cardHeight)
    }

    private var contentOverlay: some View {
        Text(side == .front ? frontText : backText)
            .font(font)
            .foregroundColor(side == .front ? frontFontColor : backFontColor)
            .padding()
            .minimumScaleFactor(Constants.minScaleFactor)
    }
}

#Preview {
    FlashcardView(
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
