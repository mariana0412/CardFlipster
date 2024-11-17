//
//  StatisticsView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

struct StatisticsView: View {

    // MARK: - Constants

    enum Constants {
        // Texts
        static let completedTitle = "You've completed all cards!"
        static let completedSubtitle = "Great job! All answers are correct!"
        static let roundSummaryTitle = "Round Summary"
        static let correctText = "Correct"
        static let incorrectText = "Incorrect"
        static let continueLearningButtonText = "Continue learning"

        // Layout
        static let spacingLarge: CGFloat = 30
        static let spacingMedium: CGFloat = 20
        static let spacingSmall: CGFloat = 10
        static let buttonPadding: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 12
        static let cardCornerRadius: CGFloat = 10
        static let cardShadowOpacity: CGFloat = 0.1
        static let cardShadowRadius: CGFloat = 5
        static let cardShadowOffsetY: CGFloat = 2
        static let cardBackgroundOpacity: CGFloat = 0.8
    }

    // MARK: - Properties

    let correctAnswers: Int
    let incorrectAnswers: Int
    let onContinue: (() -> Void)?
    let uiConfig: StatisticsScreenUIConfig

    // MARK: - Body

    var body: some View {
        ZStack {
            uiConfig.backgroundColor

            VStack(spacing: Constants.spacingLarge) {
                if incorrectAnswers == 0 {
                    completedView
                } else {
                    roundSummaryView
                }
            }
            .padding()
        }
    }

    // MARK: - Subviews

    private var completedView: some View {
        VStack(spacing: Constants.spacingSmall) {
            Text(Constants.completedTitle)
                .font(uiConfig.titleFont)
                .foregroundColor(uiConfig.textColor)
                .multilineTextAlignment(.center)

            Text(Constants.completedSubtitle)
                .font(uiConfig.subtitleFont)
                .foregroundColor(.gray)
        }
    }

    private var roundSummaryView: some View {
        VStack(spacing: Constants.spacingMedium) {
            Text(Constants.roundSummaryTitle)
                .font(uiConfig.titleFont)
                .foregroundColor(uiConfig.textColor)

            HStack(spacing: Constants.spacingMedium) {
                statisticsCard(title: Constants.correctText,
                         value: "\(correctAnswers)",
                         textColor: .green)
                statisticsCard(title: Constants.incorrectText,
                         value: "\(incorrectAnswers)",
                         textColor: .red)
            }

            if let onContinue = onContinue {
                Button(action: onContinue) {
                    Text(Constants.continueLearningButtonText)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(uiConfig.buttonBackgroundColor)
                        .foregroundColor(uiConfig.buttonTextColor)
                        .cornerRadius(Constants.buttonCornerRadius)
                        .font(.headline)
                }
                .padding(.horizontal, Constants.buttonPadding)
            }
        }
    }

    private func statisticsCard(title: String, value: String, textColor: Color) -> some View {
        VStack(spacing: Constants.spacingSmall) {
            Text(value)
                .font(.title2)
                .foregroundColor(textColor)

            Text(title)
                .font(.title2)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(Color.white.opacity(Constants.cardBackgroundOpacity))
        )
        .shadow(
            color: Color.black.opacity(Constants.cardShadowOpacity),
            radius: Constants.cardShadowRadius,
            x: 0,
            y: Constants.cardShadowOffsetY
        )
    }

}
