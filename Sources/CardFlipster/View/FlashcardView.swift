//
//  FlashcardView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 15.11.2024.
//

import SwiftUI

public struct FlashcardView: View {

    // MARK: - Constants

    private enum Constants {
        static let cardWidth: CGFloat = 300
        static let cardHeight: CGFloat = 450
        static let cornerRadius: CGFloat = 10
        static let minScaleFactor: CGFloat = 0.8
        static let swipeThreshold: CGFloat = 100
        static let swipeOffscreenDistance: CGFloat = 1000
        static let swipeAnimationDuration = 0.4
    }

    // MARK: - State

    @State private var dragOffset: CGSize = .zero
    @State private var cardOpacity: Double = 1.0
    @Binding var isFlipped: Bool

    // MARK: - Callbacks

    let onSwipeRight: () -> Void
    let onSwipeLeft: () -> Void

    // MARK: - Properties

    let frontText: String
    let backText: String
    let frontColor: Color
    let backColor: Color
    let font: Font
    let frontFontColor: Color
    let backFontColor: Color
    let axis: Axis
    let animationDuration: TimeInterval

    // MARK: - Body

    public var body: some View {
        VStack {
            cardView
        }
    }

    // MARK: - Card View

    private var cardView: some View {
        ZStack {
            cardSide(text: frontText, color: frontColor, fontColor: frontFontColor)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: resolvedAxis
                )

            cardSide(text: backText, color: backColor, fontColor: backFontColor)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -180),
                    axis: resolvedAxis
                )
        }
        .offset(x: dragOffset.width)
        .gesture(dragGesture)
        .onTapGesture(perform: handleTap)
    }

    private func cardSide(text: String, color: Color, fontColor: Color) -> some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(color)
            .overlay(
                Text(text)
                    .font(font)
                    .foregroundColor(fontColor)
                    .padding()
                    .minimumScaleFactor(Constants.minScaleFactor)
            )
            .frame(width: Constants.cardWidth, height: Constants.cardHeight)
    }

    // MARK: - Drag Gesture

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if isFlipped {
                    dragOffset = value.translation
                }
            }
            .onEnded { value in
                handleSwipe(value: value)
            }
    }

    // MARK: - Helpers

    // swiftlint:disable large_tuple
    private var resolvedAxis: (CGFloat, CGFloat, CGFloat) {
        switch axis {
        case .horizontal:
            return (0, 1, 0)
        case .vertical:
            return (1, 0, 0)
        }
    }
    // swiftlint:enable large_tuple

    private func handleTap() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isFlipped.toggle()
        }
    }

    private func handleSwipe(value: DragGesture.Value) {
        guard isFlipped else {
            resetCardPosition()
            return
        }

        let isSwipeRight = value.translation.width > Constants.swipeThreshold
        let isSwipeLeft = value.translation.width < -Constants.swipeThreshold

        if isSwipeRight || isSwipeLeft {
            performSwipeAnimation(isSwipeRight: isSwipeRight)
        } else {
            resetCardPosition()
        }
    }

    private func performSwipeAnimation(isSwipeRight: Bool) {
        withAnimation(.easeInOut(duration: Constants.swipeAnimationDuration)) {
            dragOffset.width = isSwipeRight ? Constants.swipeOffscreenDistance : -Constants.swipeOffscreenDistance
            cardOpacity = 0.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.swipeAnimationDuration) {
            if isSwipeRight {
                onSwipeRight()
            } else {
                onSwipeLeft()
            }
            resetCardAppearance()
        }
    }

    private func resetCardPosition() {
        withAnimation {
            dragOffset = .zero
        }
    }

    private func resetCardAppearance() {
        dragOffset = .zero
        cardOpacity = 1.0
    }

}

struct FlashcardViewPreview: View {
    @State private var isFlipped = false

    var body: some View {
        FlashcardView(
            isFlipped: $isFlipped,
            onSwipeRight: {
                print("Swiped Right - Correct Answer")
            },
            onSwipeLeft: {
                print("Swiped Left - Incorrect Answer")
            },
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
