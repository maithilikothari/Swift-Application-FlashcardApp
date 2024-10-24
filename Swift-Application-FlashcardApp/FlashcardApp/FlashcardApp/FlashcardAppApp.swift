//
//  FlashcardAppApp.swift
//  FlashcardApp
//
//  Created by RPS on 21/10/24.
//

import SwiftUI

@main
struct FlashcardAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
