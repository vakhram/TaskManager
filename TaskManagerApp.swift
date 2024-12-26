//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
