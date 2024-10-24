//
//  QuizHistoryView.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import Foundation
import SwiftUI

struct QuizHistoryView: View {
    @ObservedObject var progressManager: FlashcardQuizProgressManager // Change this to match your instance
    
    var body: some View {
        VStack {
            Text("Quiz History")
                .font(.largeTitle)
                .padding()
            
            // Button to clear history
            Button(action: {
                progressManager.clearHistory() // Clear history method
            }) {
                Text("Clear History")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
            }
            .padding(.bottom)

            // List to display quiz history
            List(progressManager.quizHistory) { progress in
                VStack(alignment: .leading) {
                    Text("Date: \(progress.date, formatter: dateFormatter)")
                    Text("Total Questions: \(progress.totalQuestions)")
                    Text("Correct Answers: \(progress.correctAnswers)")
                    Text("Success Rate: \(progress.successRate, specifier: "%.2f")%")
                }
                .padding() // Add padding for spacing
                .background(Color(UIColor.systemGray6)) // Add background color for visibility
                .cornerRadius(10) // Rounded corners
                .shadow(radius: 2) // Add shadow for depth
                .animation(.easeInOut) // Animation for smoothness
            }
        }
        .padding()
        .navigationTitle("Progress History")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}


