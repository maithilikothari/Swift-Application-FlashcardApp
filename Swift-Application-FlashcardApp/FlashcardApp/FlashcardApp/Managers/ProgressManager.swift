//
//  ProgressManager.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//
import Foundation

class FlashcardQuizProgressManager: ObservableObject {
    @Published var quizHistory: [QuizProgress] = []

    init() {
        loadProgress()
    }

    func addProgress(totalQuestions: Int, correctAnswers: Int) {
        // Create new QuizProgress without date
        let newProgress = QuizProgress(totalQuestions: totalQuestions, correctAnswers: correctAnswers)
        quizHistory.append(newProgress)
        saveProgress()
    }

    private func saveProgress() {
        if let encodedData = try? JSONEncoder().encode(quizHistory) {
            UserDefaults.standard.set(encodedData, forKey: "quizHistory")
        }
    }

    private func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: "quizHistory"),
           let savedHistory = try? JSONDecoder().decode([QuizProgress].self, from: data) {
            self.quizHistory = savedHistory
        }
    }

    func getAverageSuccessRate() -> Double {
        let totalQuizzes = quizHistory.count
        let totalCorrect = quizHistory.reduce(0) { $0 + $1.correctAnswers }
        let totalQuestions = quizHistory.reduce(0) { $0 + $1.totalQuestions }
        return totalQuestions > 0 ? (Double(totalCorrect) / Double(totalQuestions)) * 100 : 0
    }
    func clearHistory() {
         quizHistory.removeAll() // Clear all quiz history
     }
}





