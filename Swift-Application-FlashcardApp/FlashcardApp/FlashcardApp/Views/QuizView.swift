//
//  QuizView.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//
import SwiftUI

struct QuizView: View {
    @Binding var flashcards: [Flashcard]
    @Binding var progress: QuizProgress
    @ObservedObject var progressManager = FlashcardQuizProgressManager()
    
    @State private var currentFlashcardIndex: Int = 0
    @State private var correctAnswersCount: Int = 0
    @State private var isQuizComplete: Bool = false
    @State private var options: [String] = []
    @State private var selectedAnswer: String? = nil
    @State private var answerFeedback: Color = .clear  // Red or Green for feedback
    @State private var isAnimating: Bool = false       // To track the button animation

    @Environment(\.colorScheme) var colorScheme  // To detect dark mode
    
    var currentFlashcard: Flashcard {
        flashcards[currentFlashcardIndex]
    }
    
    var body: some View {
        VStack {
            if isQuizComplete {
                Text("Quiz Complete!")
                    .font(.largeTitle)
                    .padding()
                    .transition(.opacity)
                
                Text("Correct Answers: \(correctAnswersCount) out of \(flashcards.count)")
                    .padding()
                
                Button("Restart Quiz") {
                    withAnimation {
                        resetQuiz()
                    }
                }
                .padding()
                .background(Color(UIColor.systemBlue))
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Update Progress") {
                    progressManager.addProgress(totalQuestions: flashcards.count, correctAnswers: correctAnswersCount)
                    progress = QuizProgress(totalQuestions: flashcards.count, correctAnswers: correctAnswersCount)
                }
                .padding()
                .background(Color(UIColor.systemGreen))
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                Text("Question \(currentFlashcardIndex + 1) of \(flashcards.count)")
                    .font(.headline)
                
                Text(currentFlashcard.word)
                    .font(.largeTitle)
                    .padding()
                
                // Display multiple-choice options
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5)) {
                            isAnimating = true
                            handleAnswer(option: option)
                        }
                    }) {
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(option == selectedAnswer ? answerFeedback : (colorScheme == .dark ? Color.white.opacity(0.1) : Color.gray.opacity(0.2)))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                            .scaleEffect(isAnimating && option == selectedAnswer ? 1.1 : 1)  // Scale animation
                            .animation(.easeInOut, value: isAnimating)  // Smooth animation effect
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
        .navigationTitle("Quiz")
        .onAppear {
            loadOptions()
        }
    }
    
    // Load 1 correct answer + 3 wrong options
    func loadOptions() {
        var wrongAnswers = flashcards.filter { $0.translation != currentFlashcard.translation }
            .map { $0.translation }
            .shuffled()
        
        wrongAnswers = Array(wrongAnswers.prefix(3))  // Only 3 wrong answers
        
        options = wrongAnswers + [currentFlashcard.translation]
        options.shuffle()
    }

    // Handle answer selection and move forward
    func handleAnswer(option: String) {
        selectedAnswer = option
        
        if option == currentFlashcard.translation {
            answerFeedback = .green
            correctAnswersCount += 1
        } else {
            answerFeedback = .red
        }
        
        // After showing feedback, move to next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            selectedAnswer = nil
            answerFeedback = .clear
            isAnimating = false
            nextFlashcard()
        }
    }
    
    // Move to the next flashcard or mark quiz as complete
    func nextFlashcard() {
        if currentFlashcardIndex < flashcards.count - 1 {
            currentFlashcardIndex += 1
            loadOptions()
        } else {
            isQuizComplete = true
        }
    }
    
    // Reset the quiz to the start
    func resetQuiz() {
        currentFlashcardIndex = 0
        correctAnswersCount = 0
        isQuizComplete = false
        loadOptions()
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFlashcards = [
            Flashcard(word: "Hola", translation: "Hello", exampleSentence: "Hola"),
            Flashcard(word: "Adiós", translation: "Goodbye", exampleSentence: "Adiós"),
            Flashcard(word: "Gracias", translation: "Thank you", exampleSentence: "Gracias")
        ]
        NavigationView {
            QuizView(flashcards: .constant(sampleFlashcards), progress: .constant(QuizProgress()))
        }
    }
}
