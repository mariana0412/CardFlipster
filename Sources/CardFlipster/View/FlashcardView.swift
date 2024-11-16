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
        static let swipeThreshold: CGFloat = 100
        static let swipeOffscreenDistance: CGFloat = 1000
        static let swipeAnimationDuration = 0.4
    }

    @State private var dragOffset: CGSize = .zero
    @State private var cardOpacity: Double = 1.0
    @Binding var isFlipped: Bool

    let onSwipeRight: () -> Void
    let onSwipeLeft: () -> Void

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
            .offset(x: dragOffset.width)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if isFlipped {
                            dragOffset = value.translation
                        }
                    }
                    .onEnded { value in
                        handleSwipe(value: value)
                    }
            )
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

    private func handleSwipe(value: DragGesture.Value) {
        guard isFlipped else {
            withAnimation {
                dragOffset = .zero
            }
            return
        }

        let isSwipeRight = value.translation.width > Constants.swipeThreshold
        let isSwipeLeft = value.translation.width < -Constants.swipeThreshold

        if isSwipeRight || isSwipeLeft {
            withAnimation(.easeInOut(duration: Constants.swipeAnimationDuration)) {
                dragOffset.width = isSwipeRight ? Constants.swipeOffscreenDistance : -Constants.swipeOffscreenDistance
                cardOpacity = 0.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.swipeAnimationDuration) {
                if isSwipeRight {
                    onSwipeRight()
                } else if isSwipeLeft {
                    onSwipeLeft()
                }

                dragOffset = .zero
                cardOpacity = 1.0
            }
        } else {
            withAnimation {
                dragOffset = .zero
            }
        }
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
