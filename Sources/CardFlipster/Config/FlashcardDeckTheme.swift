//
//  FlashcardDeckTheme.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

/// A theme for `FlashcardDeckView`.
public enum FlashcardDeckTheme {

    /// A light theme with default light colors.
    case light
    /// A dark theme with default dark colors.
    case dark
    /// A custom theme with user-defined configurations.
        /// - Parameter config: The `FlashcardDeckUIConfig` containing custom configurations.
    case custom(FlashcardDeckUIConfig)

    var config: FlashcardDeckUIConfig {
        switch self {
        case .light:
            let lightGray = Color(red: 240/255, green: 241/255, blue: 239/255)

            return FlashcardDeckUIConfig(
                flashcardConfig: FlashcardUIConfig(
                    frontColor: lightGray,
                    backColor: lightGray,
                    font: .body,
                    frontFontColor: .black,
                    backFontColor: .black,
                    progressBarColor: lightGray
                ),
                statisticsConfig: StatisticsScreenUIConfig(
                    backgroundColor: LinearGradient(
                        gradient: Gradient(colors: [lightGray, .white]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    titleFont: .title,
                    subtitleFont: .subheadline,
                    textColor: .black,
                    buttonBackgroundColor: lightGray,
                    buttonTextColor: .black
                )
            )
        case .dark:
            return FlashcardDeckUIConfig(
                flashcardConfig: FlashcardUIConfig(
                    frontColor: .black,
                    backColor: .black,
                    font: .body,
                    frontFontColor: .white,
                    backFontColor: .white,
                    progressBarColor: .black
                ),
                statisticsConfig: StatisticsScreenUIConfig(
                    backgroundColor: LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.8), .gray]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    titleFont: .title,
                    subtitleFont: .subheadline,
                    textColor: .white,
                    buttonBackgroundColor: .black,
                    buttonTextColor: .white
                )
            )
        case .custom(let config):
            return config
        }
    }

}
