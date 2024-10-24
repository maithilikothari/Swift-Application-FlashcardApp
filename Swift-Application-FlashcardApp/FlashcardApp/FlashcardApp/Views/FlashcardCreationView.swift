//
//  FlashcardCreationView.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import SwiftUI

struct FlashcardCreationView: View {
    @Binding var flashcards: [Flashcard]
    @State private var word: String = ""
    @State private var translation: String = ""
    @State private var exampleSentence: String = ""

    var body: some View {
        VStack {
            TextField("Word", text: $word)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Translation", text: $translation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Example Sentence", text: $exampleSentence)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Flashcard") {
                let newFlashcard = Flashcard(word: word, translation: translation, exampleSentence: exampleSentence)
                flashcards.append(newFlashcard)
                // Clear the input fields after adding
                word = ""
                translation = ""
                exampleSentence = ""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .navigationTitle("Create Flashcard")
    }
}

struct FlashcardCreationView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardCreationView(flashcards: .constant([]))
    }
}
