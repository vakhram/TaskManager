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
    @Published private(set) var sortedTasks: [(Date?,[TaskClass])] = []
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
            self.context = context
        }
    
    func fetchTasks() {
        let fetchRequest: NSFetchRequest<TaskClass> = NSFetchRequest(entityName: "TaskEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskClass.deadlineDay, ascending: false)]
        
        do {
            tasks =  try context.fetch(fetchRequest)
            sortedTasks = sortTasksByDeadlineDay(tasks: tasks)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    func toggleTaskCompletion(_ task: TaskClass) {
        task.isCompleted.toggle()
        saveContext()
        fetchTasks()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func sortTasksByDeadlineDay(tasks: [TaskClass]) -> [(Date?,[TaskClass])] {
        // Группируем задачи по дню дедлайна
        let grouped = Dictionary(grouping: tasks) { task -> Date? in
                    guard let deadline = task.deadlineDay else { return nil }
                    return Calendar.current.startOfDay(for: deadline)
                }
        return grouped
                .sorted { (lhs, rhs) -> Bool in
                    guard let lhsDate = lhs.key, let rhsDate = rhs.key else { return false }
                    return lhsDate < rhsDate
                }
    }

}
