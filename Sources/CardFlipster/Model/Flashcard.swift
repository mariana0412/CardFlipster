//
//  Flashcard.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

/// A model representing a single flashcard with a question (front side) and an answer (back side).
public struct Flashcard {

    /// The text displayed on the front of the flashcard (e.g., a question or term).
    public let frontText: String

    /// The text displayed on the back of the flashcard (e.g., an answer or definition).
    public let backText: String

    /// Initializes a new flashcard with a question and answer.
    /// 
    /// - Parameters:
    ///   - frontText: The text displayed on the front of the flashcard.
    ///   - backText: The text displayed on the back of the flashcard.
    public init(frontText: String, backText: String) {
        self.frontText = frontText
        self.backText = backText
    }

}
