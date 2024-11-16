//
//  FlashcardDeckView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

import SwiftUI

public struct FlashcardDeckView: View {

    private enum Constants {
        static let actionButtonsHeight: CGFloat = 80
    }

    private var flashcards: [Flashcard]

    let frontColor: Color
    let backColor: Color
    let font: Font
    let frontFontColor: Color
    let backFontColor: Color
    let axis: Axis
    let animationDuration: TimeInterval

    @State private var currentIndex: Int = 0
    @State private var incorrectCards: [Flashcard] = []
    @State private var currentDeck: [Flashcard]
    @State private var isFlipped: Bool = false

    public init(
        flashcards: [Flashcard],
        frontColor: Color = .blue,
        backColor: Color = .yellow,
        font: Font = .title,
        frontFontColor: Color = .white,
        backFontColor: Color = .white,
        axis: Axis = .horizontal,
        animationDuration: TimeInterval = 0.6
    ) {
        self.flashcards = flashcards
        self.frontColor = frontColor
        self.backColor = backColor
        self.font = font
        self.frontFontColor = frontFontColor
        self.backFontColor = backFontColor
        self.axis = axis
        self.animationDuration = animationDuration
        self._currentDeck = State(initialValue: flashcards)
    }

    public var body: some View {
        VStack {
            Spacer()

            if !currentDeck.isEmpty {
                FlashcardView(
                    isFlipped: $isFlipped,
                    onSwipeRight: markCorrect,
                    onSwipeLeft: markIncorrect,
                    frontText: currentDeck[currentIndex].frontText,
                    backText: currentDeck[currentIndex].backText,
                    frontColor: frontColor,
                    backColor: backColor,
                    font: font,
                    frontFontColor: frontFontColor,
                    backFontColor: backFontColor,
                    axis: axis,
                    animationDuration: animationDuration
                )
            } else {
                Text("Well done! You've answered all cards correctly!")
                    .font(.headline)
                    .padding()
            }

            Spacer()

            fixedActionButtons
        }
    }

    private var fixedActionButtons: some View {
        VStack {
            if isFlipped {
                actionButtons
            } else {
                Spacer().frame(height: Constants.actionButtonsHeight)
            }
        }
        .animation(.easeInOut, value: isFlipped)
    }

    private var actionButtons: some View {
        HStack {
            Button(action: markIncorrect) {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
            }
            .disabled(currentDeck.isEmpty)

            Spacer()

            Button(action: markCorrect) {
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }
            .disabled(currentDeck.isEmpty)
        }
        .frame(height: Constants.actionButtonsHeight)
        .padding(.horizontal)
    }

    private func markCorrect() {
        moveToNextCard()
    }

    private func markIncorrect() {
        incorrectCards.append(currentDeck[currentIndex])
        moveToNextCard()
    }

    private func moveToNextCard() {
        if currentIndex < currentDeck.count - 1 {
            currentIndex += 1
        } else {
            restartWithIncorrectCards()
        }
        resetFlipState()
    }

    private func restartWithIncorrectCards() {
        if incorrectCards.isEmpty {
            currentDeck = []
        } else {
            currentDeck = incorrectCards
            incorrectCards = []
        }
        currentIndex = 0
    }

    private func resetFlipState() {
        isFlipped = false
    }
}

struct FlashcardDeckPreview: View {
    var body: some View {
        FlashcardDeckView(
            flashcards: sampleFlashcards,
            frontColor: .blue,
            backColor: .orange,
            font: .headline,
            axis: .horizontal,
            animationDuration: 0.5
        )
    }

    private var sampleFlashcards: [Flashcard] {
        [
            Flashcard(frontText: "What is the capital of Ukraine?", backText: "Kyiv"),
            Flashcard(frontText: "What is the capital of France?", backText: "Paris"),
            Flashcard(frontText: "What is the capital of Italy?", backText: "Rome")
        ]
    }
}

#Preview {
    FlashcardDeckPreview()
}
