//
//  StatisticsView.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

struct StatisticsView: View {

    enum Constants {
        static let completedTitle = "You've completed all cards!"
        static let completedSubtitle = "Great job! All answers are correct!"
        static let roundSummaryTitle = "Round Summary"
        static let correctText = "Correct"
        static let incorrectText = "Incorrect"
        static let continueLearningButtonText = "Continue learning"

        static let correctColor: Color = .green
        static let incorrectColor: Color = .red
        static let buttonColor: Color = .blue
        static let buttonTextColor: Color = .white
    }

    let correctAnswers: Int
    let incorrectAnswers: Int
    let onContinue: (() -> Void)?

    let frontColor: Color
    let backColor: Color
    let fontColor: Color

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [frontColor.opacity(0.5), backColor.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack(spacing: 30) {
                if incorrectAnswers == 0 {
                    completedView
                } else {
                    roundSummaryView
                }
            }
            .padding()
        }
    }

    private var completedView: some View {
        VStack(spacing: 10) {
            Text(Constants.completedTitle)
                .font(.largeTitle)
                .foregroundColor(fontColor)
                .multilineTextAlignment(.center)

            Text(Constants.completedSubtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

    private var roundSummaryView: some View {
        VStack(spacing: 10) {
            Text(Constants.roundSummaryTitle)
                .font(.largeTitle)
                .foregroundColor(fontColor)

            HStack(spacing: 20) {
                statCard(title: Constants.correctText, value: "\(correctAnswers)", color: Constants.correctColor)
                statCard(title: Constants.incorrectText, value: "\(incorrectAnswers)", color: Constants.incorrectColor)
            }

            if let onContinue = onContinue {
                Button(action: onContinue) {
                    Text(Constants.continueLearningButtonText)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Constants.buttonColor)
                        .foregroundColor(Constants.buttonTextColor)
                        .cornerRadius(12)
                        .font(.headline)
                }
                .padding(.horizontal, 20)
            }
        }
    }

    private func statCard(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.title2)
                .foregroundColor(color)

            Text(title)
                .font(.title2)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }

}
