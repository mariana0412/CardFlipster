//
//  FlashcardDeckView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

import SwiftUI

/// A SwiftUI view that displays a deck of flashcards.
public struct FlashcardDeckView: View {

    private enum Constants {
        static let progressBarSpacing: CGFloat = 5
        static let progressBarHeightScale: CGFloat = 2

        static let actionButtonsHeight: CGFloat = 80
    }

    // MARK: - Properties

    @StateObject private var viewModel: FlashcardDeckViewModel

    private let uiConfig: FlashcardDeckUIConfig

    // MARK: - Init

    /**
     Creates a flashcard deck view with the given flashcards and theme.
     - Parameters:
        - flashcards: An array of `Flashcard` objects to be displayed in the deck.
        - theme: The theme for configuring the appearance of the flashcard deck.
     */
    public init(flashcards: [Flashcard], theme: FlashcardDeckTheme = .light) {
        _viewModel = StateObject(wrappedValue: FlashcardDeckViewModel(flashcards: flashcards))
        self.uiConfig = theme.config
    }

    // MARK: - Body

    /// The content and behavior of the flashcard deck view.
    public var body: some View {
        ZStack {
            VStack {
                if !viewModel.roundCompleted {
                    progressView
                }

                Spacer()

                if !viewModel.roundCompleted {
                    FlashcardView(
                        isFlipped: $viewModel.isFlipped,
                        onSwipeRight: viewModel.markCorrect,
                        onSwipeLeft: viewModel.markIncorrect,
                        frontText: viewModel.currentDeck[viewModel.currentIndex].frontText,
                        backText: viewModel.currentDeck[viewModel.currentIndex].backText,
                        uiConfig: uiConfig.flashcardConfig,
                        axis: .horizontal,
                        animationDuration: 0.6
                    )
                }

                Spacer()

                if !viewModel.roundCompleted {
                    fixedActionButtons
                }
            }

            if viewModel.roundCompleted {
                StatisticsView(
                    correctAnswers: viewModel.correctAnswersCount,
                    incorrectAnswers: viewModel.incorrectAnswersCount,
                    onContinue: viewModel.incorrectAnswersCount > 0 ? viewModel.restartWithIncorrectCards : nil,
                    uiConfig: uiConfig.statisticsConfig
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
        .animation(viewModel.roundCompleted ? nil : .easeInOut, value: viewModel.roundCompleted)
    }

    // MARK: - Subviews

    private var progressView: some View {
        VStack(spacing: Constants.progressBarSpacing) {
            ProgressView(value: progressValue, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: uiConfig.flashcardConfig.progressBarColor))
                .scaleEffect(x: 1, y: Constants.progressBarHeightScale, anchor: .center)
                .padding(.horizontal)

            Text("\(viewModel.currentIndex)/\(viewModel.currentDeck.count)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.top)
    }

    private var progressValue: Double {
        guard viewModel.currentDeck.count > 0 else { return 0 }
        return Double(viewModel.correctAnswersCount + viewModel.incorrectAnswersCount)
        / Double(viewModel.currentDeck.count)
    }

    private var fixedActionButtons: some View {
        VStack {
            if viewModel.isFlipped {
                actionButtons
            } else {
                Spacer().frame(height: Constants.actionButtonsHeight)
            }
        }
        .animation(.easeInOut, value: viewModel.isFlipped)
    }

    private var actionButtons: some View {
        HStack {
            Button(action: viewModel.markIncorrect) {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
            }
            .disabled(viewModel.currentDeck.isEmpty)

            Spacer()

            Button(action: viewModel.markCorrect) {
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }
            .disabled(viewModel.currentDeck.isEmpty)
        }
        .frame(height: Constants.actionButtonsHeight)
        .padding(.horizontal)
    }

}
