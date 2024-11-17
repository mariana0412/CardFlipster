//
//  StatisticsScreenUIConfig.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

public struct StatisticsScreenUIConfig {
    public let backgroundColor: LinearGradient
    public let titleFont: Font
    public let subtitleFont: Font
    public let textColor: Color
    public let buttonBackgroundColor: Color
    public let buttonTextColor: Color

    public init(
        backgroundColor: LinearGradient,
        titleFont: Font,
        subtitleFont: Font,
        textColor: Color,
        buttonBackgroundColor: Color,
        buttonTextColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.textColor = textColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonTextColor = buttonTextColor
    }

}
