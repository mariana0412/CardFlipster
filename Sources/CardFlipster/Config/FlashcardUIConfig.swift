//
//  FlashcardUIConfig.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

/// Configuration for customizing the appearance of the flashcard view.
public struct FlashcardUIConfig {

    /// The background color of the front side of the flashcard.
    public let frontColor: Color

    /// The background color of the back side of the flashcard.
    public let backColor: Color

    /// The font used for the text on both sides of the flashcard.
    public let font: Font

    /// The color of the text on the front side of the flashcard.
    public let frontFontColor: Color

    /// The color of the text on the back side of the flashcard.
    public let backFontColor: Color

    /// The color of the progress bar displayed during the round.
    public let progressBarColor: Color

    /**
     Initializes a new configuration for a flashcard.
     - Parameters:
       - frontColor: The background color of the front side of the flashcard.
       - backColor: The background color of the back side of the flashcard.
       - font: The font used for the text on both sides of the flashcard.
       - frontFontColor: The color of the text on the front side of the flashcard.
       - backFontColor: The color of the text on the back side of the flashcard.
       - progressBarColor: The color of the progress bar displayed during the round.
     */
    public init(
        frontColor: Color,
        backColor: Color,
        font: Font,
        frontFontColor: Color,
        backFontColor: Color,
        progressBarColor: Color
    ) {
        self.frontColor = frontColor
        self.backColor = backColor
        self.font = font
        self.frontFontColor = frontFontColor
        self.backFontColor = backFontColor
        self.progressBarColor = progressBarColor
    }

}
