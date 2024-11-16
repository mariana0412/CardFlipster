//
//  FlashcardDeckViewModel.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

import SwiftUI

public class FlashcardDeckViewModel: ObservableObject {

    // MARK: - Properties

    private let originalFlashcards: [Flashcard]
    private var incorrectCards: [Flashcard] = []

    @Published var currentDeck: [Flashcard]
    @Published var currentIndex: Int = 0
    @Published var isFlipped: Bool = false
    @Published var roundCompleted: Bool = false
    @Published var correctAnswersCount: Int = 0
    @Published var incorrectAnswersCount: Int = 0

    // MARK: - Initialization

    init(flashcards: [Flashcard]) {
        self.originalFlashcards = flashcards
        self.currentDeck = flashcards
    }

    // MARK: - Methods

    func markCorrect() {
        correctAnswersCount += 1
        moveToNextCard()
    }

    func markIncorrect() {
        incorrectAnswersCount += 1
        incorrectCards.append(currentDeck[currentIndex])
        moveToNextCard()
    }

    func restartWithIncorrectCards() {
        currentDeck = incorrectCards
        incorrectCards = []
        correctAnswersCount = 0
        incorrectAnswersCount = 0
        currentIndex = 0
        roundCompleted = false
    }

    func resetFlipState() {
        isFlipped = false
    }

    private func moveToNextCard() {
        if currentIndex < (currentDeck.count - 1) {
            currentIndex += 1
        } else {
            completeRound()
        }

        resetFlipState()
    }

    private func completeRound() {
        roundCompleted = true
        if incorrectCards.isEmpty {
            currentDeck = []
        }
    }

}
