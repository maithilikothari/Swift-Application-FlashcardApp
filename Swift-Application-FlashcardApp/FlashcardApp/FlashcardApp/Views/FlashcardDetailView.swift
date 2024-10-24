//
//  FlashcardDetailView.swift
//  FlashcardApp
//
//  Created by RPS on 22/10/24.
//

import SwiftUI

struct FlashcardDetailView: View {
    var flashcard: Flashcard
    @State private var isFlipped: Bool = false

    var body: some View {
        ZStack {
            // Background color for dark mode support
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Card view with flipping animation
                VStack {
                    if !isFlipped {
                        // Front side of the card (showing word and translation)
                        VStack {
                            Text(flashcard.word)
                                .font(.largeTitle)
                                .foregroundColor(.primary) // Adapt to dark/light mode
                                .padding()

                            Text(flashcard.translation)
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                        }
                    } else {
                        // Back side of the card (showing example sentence)
                        VStack {
                            Text(flashcard.exampleSentence)
                                .font(.title)
                                .foregroundColor(.primary) // Adapt to dark/light mode
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                }
                .frame(maxWidth: 300, maxHeight: 200) // Set consistent height and width
                .background(Color(UIColor.systemGray5)) // Neutral background color
                .cornerRadius(10)
                .shadow(radius: 5)
                .rotation3DEffect(
                    .degrees(isFlipped ? 360 : 0), // Flipping animation
                    axis: (x: 0, y: 1, z: 0) // Rotate along Y-axis
                )
                .animation(.easeInOut, value: isFlipped) // Animate the flipping
            }
            .onTapGesture {
                withAnimation {
                    isFlipped.toggle() // Flip card on tap
                }
            }
        }
        .navigationTitle("Flashcard Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FlashcardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFlashcard = Flashcard(word: "Hola", translation: "Hello", exampleSentence: "Hola en español")
        FlashcardDetailView(flashcard: sampleFlashcard)
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
