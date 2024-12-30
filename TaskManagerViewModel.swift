//
//  TaskManagerViewModel.swift
//  TaskManager
//
//  Created by Guest Acc on 28.12.2024.
//

import Foundation
import SwiftUI
import CoreData

class TaskManagerViewModel: ObservableObject {
    
    @Published private(set) var tasks: [TaskClass] = []
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
            self.context = context
        }
    
    func fetchTasks() {
        let fetchRequest: NSFetchRequest<TaskClass> = NSFetchRequest(entityName: "TaskEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskClass.deadlineDay, ascending: true)]
        
        do {
            tasks =  try context.fetch(fetchRequest)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    func toggleTaskCompletion(_ task: TaskClass) {
        task.isCompleted.toggle()
        saveContext()
        fetchTasks() // Обновляем список задач
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
