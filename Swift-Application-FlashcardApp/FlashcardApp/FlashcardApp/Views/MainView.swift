//
//  MainView.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var flashcards: [Flashcard] = []
    @State private var progress: QuizProgress = QuizProgress()

    var body: some View {
        TabView {
            // Flashcards List Tab
            NavigationView {
                VStack {
                    if flashcards.isEmpty {
                        EmptyStateView()
                    } else {
                        FlashcardListView(flashcards: $flashcards) // Use list view
                    }
                }
                .navigationTitle("Flashcards")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: FlashcardCreationView(flashcards: $flashcards)) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                }
            }
            .tabItem {
                Label("Flashcards", systemImage: "book.fill")
            }

            // Quiz Tab
            NavigationView {
                VStack {
                    NavigationLink(destination: QuizView(flashcards: $flashcards, progress: $progress)) {
                        Text("Start Quiz")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                }
                .navigationTitle("Quiz")
            }
            .tabItem {
                Label("Quiz", systemImage: "questionmark.circle.fill")
            }

            // Progress Tab
            NavigationView {
                VStack {
                    NavigationLink(destination: ProgressView(progress: $progress)) {
                        Text("View Progress")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                }
                .navigationTitle("Progress")
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }

            // Quiz History Tab
            NavigationView {
                QuizHistoryView(progressManager: FlashcardQuizProgressManager())
                    .navigationTitle("Quiz History")
            }
            .tabItem {
                Label("History", systemImage: "clock.fill")
            }
        }
    }
}

// Flashcard List View to display flashcards in a simpler, less button-like format
struct FlashcardListView: View {
    @Binding var flashcards: [Flashcard]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(flashcards) { flashcard in
                    NavigationLink(destination: FlashcardDetailView(flashcard: flashcard)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(flashcard.word)
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                // Keep translation hidden here to emphasize the word
                                Text(flashcard.exampleSentence) // Display example for context
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "book.fill")
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
            }
            .padding()
        }
    }
}

// Empty State View when no flashcards are added
struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "books.vertical")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
                .foregroundColor(.gray)
            Text("No Flashcards Yet")
                .font(.title)
                .foregroundColor(.gray)
            Text("Tap the '+' button to start adding flashcards!")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.top, 100)
    }
}

// Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
