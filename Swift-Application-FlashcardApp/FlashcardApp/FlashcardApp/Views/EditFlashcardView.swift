//
//  EditFlashcardView.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import Foundation
import SwiftUI

struct EditFlashcardView: View {
    @Binding var flashcards: [Flashcard]
    @State private var word: String = ""
    @State private var translation: String = ""
    @Environment(\.dismiss) private var dismiss  // Use this for iOS 15 and later
    
    var body: some View {
        VStack {
            TextField("Word", text: $word)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Translation", text: $translation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save Flashcard") {
                saveFlashcard()
                dismiss()  // Navigate back after saving
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }

    func saveFlashcard() {
        let newFlashcard = Flashcard(word: word, translation: translation, exampleSentence: "")
        flashcards.append(newFlashcard)
    }
}


