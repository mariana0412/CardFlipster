//
//  FlashcardDeckViewModelTests.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import XCTest
@testable import CardFlipster

final class FlashcardDeckViewModelTests: XCTestCase {

    var viewModel: FlashcardDeckViewModel!
    var flashcards: [Flashcard]!

    override func setUp() {
        super.setUp()

        flashcards = [
            Flashcard(frontText: "What is the capital of Ukraine?", backText: "Kyiv"),
            Flashcard(frontText: "What is the capital of France?", backText: "Paris")
        ]
        viewModel = FlashcardDeckViewModel(flashcards: flashcards)
    }

    override func tearDown() {
        viewModel = nil
        flashcards = nil

        super.tearDown()
    }

    func testInitialization() {
        XCTAssertEqual(viewModel.currentDeck.count, 2,
                       "Current deck should have 2 flashcards.")
        XCTAssertEqual(viewModel.correctAnswersCount, 0,
                       "Correct answers count should start with 0.")
        XCTAssertEqual(viewModel.incorrectAnswersCount, 0,
                       "Incorrect answers count should start with 0.")
        XCTAssertFalse(viewModel.roundCompleted,
                       "Round should not be completed at the start.")
        XCTAssertFalse(viewModel.isFlipped,
                       "Flashcards should not be flipped at the start.")
    }

    func testMarkCorrect_IncreasesCorrectCount() {
        viewModel.markCorrect()

        XCTAssertEqual(viewModel.correctAnswersCount, 1,
                       "Correct answers count should increase by 1.")
        XCTAssertEqual(viewModel.incorrectAnswersCount, 0,
                       "Incorrect answers count should remain at 0.")
    }

    func testMarkIncorrect_IncreasesIncorrectCount() {
        viewModel.markIncorrect()

        XCTAssertEqual(viewModel.incorrectAnswersCount, 1,
                       "Incorrect answers count should increase by 1.")
        XCTAssertEqual(viewModel.correctAnswersCount, 0,
                       "Correct answers count should remain at 0.")
    }

    func testRoundNotCompleted_AfterSingleCorrectAnswer() {
        viewModel.markCorrect()

        XCTAssertFalse(viewModel.roundCompleted,
                       "Round should not be completed after 1 flashcard because there are 2 of them.")
    }

    func testRoundCompleted_AfterAllCardsAnswered() {
        viewModel.markCorrect()
        viewModel.markCorrect()

        XCTAssertTrue(viewModel.roundCompleted,
                      "Round should be completed after answering all cards.")
    }

    func testRestart_WithIncorrectCards() {
        viewModel.markIncorrect()
        viewModel.markCorrect()
        viewModel.restartWithIncorrectCards()

        XCTAssertEqual(viewModel.correctAnswersCount, 0,
                       "Correct answers count should be reset to 0 after restart.")
        XCTAssertEqual(viewModel.incorrectAnswersCount, 0,
                       "Incorrect answers count should be reset to 0 after restart.")
        XCTAssertEqual(viewModel.currentDeck.count, 1,
                       "Current deck should contain only the incorrect cards.")
        XCTAssertFalse(viewModel.roundCompleted,
                       "Round should not be completed after restart.")
    }

    func testCompleteRound_WithNoIncorrectCards() {
        viewModel.markCorrect()
        viewModel.markCorrect()

        XCTAssertTrue(viewModel.roundCompleted,
                      "Round should be completed when no incorrect cards remain.")
        XCTAssertEqual(viewModel.currentDeck.count, 0,
                       "Current deck should be empty after completing the round.")
        XCTAssertEqual(viewModel.correctAnswersCount, 2,
                       "Correct answers count should equal the number of cards.")
    }

    func testResetFlipState() {
        viewModel.isFlipped = true
        viewModel.resetFlipState()

        XCTAssertFalse(viewModel.isFlipped, "Flip state should reset to false.")
    }

}
