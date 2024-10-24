//
//  Flashcard.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import Foundation

struct Flashcard: Identifiable {
    var id = UUID()
    var word: String
    var translation: String
    var exampleSentence: String
    var lastReviewed: Date?
    var interval: TimeInterval = 86400 // Default to 1 day
}

