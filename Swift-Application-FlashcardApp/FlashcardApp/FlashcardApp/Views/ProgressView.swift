//
//  ProgressView.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import SwiftUI
import Charts

struct ProgressView: View {
    @Binding var progress: QuizProgress // Bind to the progress from MainView
    
    var body: some View {
        VStack {
            Text("Progress Overview")
                .font(.largeTitle)
                .padding()
            
            Text("Total Questions: \(progress.totalQuestions)")
                .padding()
            
            Text("Correct Answers: \(progress.correctAnswers)")
                .padding()
            
            Text("Success Rate: \(progress.successRate, specifier: "%.2f")%")
                .padding()
            
            // Bar chart implementation
            Chart {
                BarMark(
                    x: .value("Result", "Correct"),
                    y: .value("Count", progress.correctAnswers)
                )
                BarMark(
                    x: .value("Result", "Incorrect"),
                    y: .value("Count", progress.totalQuestions - progress.correctAnswers)
                )
            }
            .frame(height: 300) // Set the frame height for the chart
            .padding()
            .background(Color(UIColor.systemBackground)) // Optional: set background color
            .cornerRadius(12) // Optional: add corner radius
            .shadow(radius: 5) // Optional: add shadow
        }
        .padding()
        .navigationTitle("Progress")
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: .constant(QuizProgress(totalQuestions: 10, correctAnswers: 5)))
    }
}


