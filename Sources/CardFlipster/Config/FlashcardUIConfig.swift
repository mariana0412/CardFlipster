//
//  FlashcardUIConfig.swift
//  CardFlipster
//
//  Created by Mariana Piz on 17.11.2024.
//

import SwiftUI

public struct FlashcardUIConfig {
    public let frontColor: Color
    public let backColor: Color
    public let font: Font
    public let frontFontColor: Color
    public let backFontColor: Color
    public let progressBarColor: Color

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
