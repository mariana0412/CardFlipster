//
//  FlashcardDeckThemeTests.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI
import XCTest
@testable import CardFlipster

final class FlashcardDeckThemeTests: XCTestCase {

    func testLightThemeConfiguration() {
        let theme = FlashcardDeckTheme.light
        let config = theme.config
        let lightGray = Color(red: 240/255, green: 241/255, blue: 239/255)

        XCTAssertEqual(config.flashcardConfig.frontColor, lightGray)
        XCTAssertEqual(config.flashcardConfig.backColor, lightGray)
        XCTAssertEqual(config.flashcardConfig.font, .body)
        XCTAssertEqual(config.flashcardConfig.frontFontColor, .black)
        XCTAssertEqual(config.flashcardConfig.backFontColor, .black)
        XCTAssertEqual(config.flashcardConfig.progressBarColor, lightGray)

        XCTAssertEqual(config.statisticsConfig.textColor, .black)
        XCTAssertEqual(config.statisticsConfig.continueButtonBackgroundColor, lightGray)
        XCTAssertEqual(config.statisticsConfig.continueButtonTextColor, .black)
        XCTAssertEqual(config.statisticsConfig.titleFont, .title)
        XCTAssertEqual(config.statisticsConfig.subtitleFont, .subheadline)
    }

    func testDarkThemeConfiguration() {
        let theme = FlashcardDeckTheme.dark
        let config = theme.config

        XCTAssertEqual(config.flashcardConfig.frontColor, .black)
        XCTAssertEqual(config.flashcardConfig.backColor, .black)
        XCTAssertEqual(config.flashcardConfig.font, .body)
        XCTAssertEqual(config.flashcardConfig.frontFontColor, .white)
        XCTAssertEqual(config.flashcardConfig.backFontColor, .white)
        XCTAssertEqual(config.flashcardConfig.progressBarColor, .black)

        XCTAssertEqual(config.statisticsConfig.textColor, .white)
        XCTAssertEqual(config.statisticsConfig.continueButtonBackgroundColor, .black)
        XCTAssertEqual(config.statisticsConfig.continueButtonTextColor, .white)
        XCTAssertEqual(config.statisticsConfig.titleFont, .title)
        XCTAssertEqual(config.statisticsConfig.subtitleFont, .subheadline)
    }

    func testCustomThemeConfiguration() {
        let customFlashcardConfig = FlashcardUIConfig(
            frontColor: .purple,
            backColor: .pink,
            font: .largeTitle,
            frontFontColor: .yellow,
            backFontColor: .blue,
            progressBarColor: .green
        )

        let customStatisticsConfig = StatisticsScreenUIConfig(
            backgroundColor: LinearGradient(
                gradient: Gradient(colors: [.purple, .pink]),
                startPoint: .leading,
                endPoint: .trailing
            ),
            titleFont: .headline,
            subtitleFont: .footnote,
            textColor: .blue,
            buttonBackgroundColor: .purple,
            buttonTextColor: .yellow
        )

        let customTheme = FlashcardDeckTheme.custom(
            FlashcardDeckUIConfig(
                flashcardConfig: customFlashcardConfig,
                statisticsConfig: customStatisticsConfig
            )
        )

        let config = customTheme.config

        XCTAssertEqual(config.flashcardConfig.frontColor, .purple)
        XCTAssertEqual(config.flashcardConfig.backColor, .pink)
        XCTAssertEqual(config.flashcardConfig.font, .largeTitle)
        XCTAssertEqual(config.flashcardConfig.frontFontColor, .yellow)
        XCTAssertEqual(config.flashcardConfig.backFontColor, .blue)
        XCTAssertEqual(config.flashcardConfig.progressBarColor, .green)

        XCTAssertEqual(config.statisticsConfig.textColor, .blue)
        XCTAssertEqual(config.statisticsConfig.continueButtonBackgroundColor, .purple)
        XCTAssertEqual(config.statisticsConfig.continueButtonTextColor, .yellow)
        XCTAssertEqual(config.statisticsConfig.titleFont, .headline)
        XCTAssertEqual(config.statisticsConfig.subtitleFont, .footnote)
    }
}
