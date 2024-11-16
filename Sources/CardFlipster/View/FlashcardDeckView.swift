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

    let frontColor: Color
    let backColor: Color
    let font: Font
    let frontFontColor: Color
    let backFontColor: Color
    let axis: Axis
    let animationDuration: TimeInterval

    // MARK: - Init

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
        _viewModel = StateObject(wrappedValue: FlashcardDeckViewModel(flashcards: flashcards))
        self.frontColor = frontColor
        self.backColor = backColor
        self.font = font
        self.frontFontColor = frontFontColor
        self.backFontColor = backFontColor
        self.axis = axis
        self.animationDuration = animationDuration
    }

    // MARK: - Body

    public var body: some View {
        VStack {
            if !viewModel.roundCompleted {
                progressView
            }

            Spacer()

            if viewModel.roundCompleted {
                statisticsView
            } else if !viewModel.currentDeck.isEmpty {
                FlashcardView(
                    isFlipped: $viewModel.isFlipped,
                    onSwipeRight: viewModel.markCorrect,
                    onSwipeLeft: viewModel.markIncorrect,
                    frontText: viewModel.currentDeck[viewModel.currentIndex].frontText,
                    backText: viewModel.currentDeck[viewModel.currentIndex].backText,
                    frontColor: frontColor,
                    backColor: backColor,
                    font: font,
                    frontFontColor: frontFontColor,
                    backFontColor: backFontColor,
                    axis: axis,
                    animationDuration: animationDuration
                )
            }

            Spacer()

            fixedActionButtons
        }
    }

    // MARK: - Subviews

    private var progressView: some View {
        VStack(spacing: Constants.progressBarSpacing) {
            ProgressView(value: progressValue, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
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
        return Double(viewModel.correctAnswers + viewModel.incorrectAnswers) / Double(viewModel.currentDeck.count)
    }

    private var statisticsView: some View {
        VStack(spacing: 20) {
            if viewModel.incorrectAnswers == 0 {
                Text("You've completed all cards!")
                    .font(.headline)
                    .foregroundColor(.green)
            } else {
                Text("Round Summary")
                    .font(.headline)

                Text("Correct: \(viewModel.correctAnswers)")
                    .foregroundColor(.green)

                Text("Incorrect: \(viewModel.incorrectAnswers)")
                    .foregroundColor(.red)

                Button("Continue learning") {
                    viewModel.restartWithIncorrectCards()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
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
