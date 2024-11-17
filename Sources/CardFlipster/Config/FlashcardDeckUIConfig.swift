//
//  FlashcardDeckUIConfig.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

public struct FlashcardDeckUIConfig {
    public let flashcardConfig: FlashcardUIConfig
    public let statisticsConfig: StatisticsScreenUIConfig

    public init(
        flashcardConfig: FlashcardUIConfig,
        statisticsConfig: StatisticsScreenUIConfig
    ) {
        self.flashcardConfig = flashcardConfig
        self.statisticsConfig = statisticsConfig
    }
}
