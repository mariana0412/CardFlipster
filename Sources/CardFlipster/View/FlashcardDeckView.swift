//
//  FlashcardDeckView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

import SwiftUI

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

    public init(flashcards: [Flashcard], theme: FlashcardDeckTheme = .light) {
        _viewModel = StateObject(wrappedValue: FlashcardDeckViewModel(flashcards: flashcards))
        self.uiConfig = theme.config
    }

    // MARK: - Body

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

#Preview {
    var flashcards: [Flashcard] {
        [
            Flashcard(frontText: "What is the capital of Ukraine?", backText: "Kyiv"),
            Flashcard(frontText: "What is the capital of France?", backText: "Paris"),
            Flashcard(frontText: "What is the capital of Italy?", backText: "Rome")
        ]
    }

    let softLavender = Color(red: 220/255, green: 180/255, blue: 255/255)
    let pastelPink = Color(red: 255/255, green: 200/255, blue: 230/255)

    let flashcardConfig = FlashcardUIConfig(
        frontColor: softLavender,
        backColor: pastelPink,
        font: .title,
        frontFontColor: .white,
        backFontColor: .white,
        progressBarColor: pastelPink
    )

    let statisticsConfig = StatisticsScreenUIConfig(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [softLavender, pastelPink]),
            startPoint: .top,
            endPoint: .bottom
        ),
        titleFont: .largeTitle,
        subtitleFont: .headline,
        textColor: .white,
        buttonBackgroundColor: softLavender,
        buttonTextColor: .white
    )

    let customTheme = FlashcardDeckTheme.custom(
        FlashcardDeckUIConfig(
            flashcardConfig: flashcardConfig,
            statisticsConfig: statisticsConfig
        )
    )

    return FlashcardDeckView(flashcards: flashcards, theme: .dark)
}
