//
//  FlashcardDeckUIConfig.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

/// A configuration object for customizing the appearance of the flashcard deck and statistics screen.
public struct FlashcardDeckUIConfig {

    /// The appearance configuration for the flashcards.
    public let flashcardConfig: FlashcardUIConfig

    /// The appearance configuration for the statistics screen.
    public let statisticsConfig: StatisticsScreenUIConfig

    /// Initializes a new configuration object for the flashcard deck.
    ///
    /// - Parameters:
    ///   - flashcardConfig: The appearance configuration for the flashcards.
    ///   - statisticsConfig: The appearance configuration for the statistics screen.
    public init(
        flashcardConfig: FlashcardUIConfig,
        statisticsConfig: StatisticsScreenUIConfig
    ) {
        self.flashcardConfig = flashcardConfig
        self.statisticsConfig = statisticsConfig
    }

}
