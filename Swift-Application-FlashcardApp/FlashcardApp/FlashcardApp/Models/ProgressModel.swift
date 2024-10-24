//
//  ProgressModel.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import Foundation

struct QuizProgress: Identifiable, Codable {
    var id = UUID()
    var date: Date // Add date property
    var totalQuestions: Int = 0
    var correctAnswers: Int = 0

    var successRate: Double {
        return totalQuestions > 0 ? (Double(correctAnswers) / Double(totalQuestions)) * 100 : 0
    }

    // Initializer updated to include date
    init(date: Date = Date(), totalQuestions: Int = 0, correctAnswers: Int = 0) {
        self.date = date
        self.totalQuestions = totalQuestions
        self.correctAnswers = correctAnswers
    }

    mutating func update(correctAnswers: Int, totalQuestions: Int) {
        self.correctAnswers += correctAnswers
        self.totalQuestions += totalQuestions
    }
}











