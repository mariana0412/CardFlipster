//
//  StatisticsScreenUIConfig.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

/// Configuration for customizing the appearance of the statistics screen.
public struct StatisticsScreenUIConfig {

    /// The background color of the statistics screen.
    public let backgroundColor: LinearGradient

    /// The font used for the title text.
    public let titleFont: Font

    /// The font used for the subtitle text.
    public let subtitleFont: Font

    /// The color of the text displayed on the statistics screen.
    public let textColor: Color

    /// The background color for the button that allows users to retry with flashcards marked as answered incorrectly.
    public let continueButtonBackgroundColor: Color

    /// The text color for the button that allows users to retry with flashcards marked as answered incorrectly.
    public let continueButtonTextColor: Color

    /// The title displayed at the top of the statistics screen.
    public let roundSummaryTitle: String

    /// The label text for correct answers on the statistics screen.
    public let correctText: String

    /// The label text for incorrect answers on the statistics screen.
    public let incorrectText: String

    /// The text displayed on the button that allows users to retry with flashcards marked as answered incorrectly.
    public let continueLearningButtonText: String

    /**
     Initializes a new configuration for the statistics screen.
     - Parameters:
       - backgroundColor: The background color of the statistics screen.
       - titleFont: The font used for the title text.
       - subtitleFont: The font used for the subtitle text.
       - textColor: The color of the text displayed on the statistics screen.
       - continueButtonBackgroundColor: The background color for the retry button for incorrectly answered flashcards.
       - continueButtonTextColor: The text color for the retry button for incorrectly answered flashcards.
       - roundSummaryTitle: The title displayed at the top of the statistics screen. Defaults to "Round Summary".
       - correctText: The label text for correct answers. Defaults to "Correct".
       - incorrectText: The label text for incorrect answers. Defaults to "Incorrect".
       - continueLearningButtonText: The text on the retry button for incorrectly answered flashcards.
     */
    public init(
        backgroundColor: LinearGradient,
        titleFont: Font,
        subtitleFont: Font,
        textColor: Color,
        buttonBackgroundColor: Color,
        buttonTextColor: Color,
        roundSummaryTitle: String = "Round Summary",
        correctText: String = "Correct",
        incorrectText: String = "Incorrect",
        continueLearningButtonText: String = "Continue learning"
    ) {
        self.backgroundColor = backgroundColor
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.textColor = textColor
        self.continueButtonBackgroundColor = buttonBackgroundColor
        self.continueButtonTextColor = buttonTextColor
        self.roundSummaryTitle = roundSummaryTitle
        self.correctText = correctText
        self.incorrectText = incorrectText
        self.continueLearningButtonText = continueLearningButtonText
    }

}
