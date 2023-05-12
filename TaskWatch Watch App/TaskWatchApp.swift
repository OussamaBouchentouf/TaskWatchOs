//
//  TaskWatchApp.swift
//  TaskWatch Watch App
//
//  Created by Robotics on 11/5/2023.
//

import SwiftUI

@main
struct TaskWatch_Watch_AppApp: App {
    let container = PersistenceController.shared.container
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environment(\.managedObjectContext, container.viewContext)
        }
    }
}
