//
//  FridgeTrackerApp.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import SwiftUI

@main
struct FridgeTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LocationNavView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
