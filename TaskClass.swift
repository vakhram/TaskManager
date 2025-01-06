//
//  Task.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import Foundation
import CoreData

@objc(TaskClass)
class TaskClass: NSManagedObject, Identifiable {
    
    @NSManaged var taskName: String
    @NSManaged var isCompleted: Bool
    @NSManaged var deadlineDay: Date?
    @NSManaged var deadlineTime: Date?
    
    @NSManaged var id: UUID
    
    override var debugDescription: String {
        return "id: \(id), taskName: \(taskName), isCompleted: \(isCompleted)"
    }
    
}
