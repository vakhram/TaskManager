//
//  Data Controller.swift
//  TaskManager
//
//  Created by Guest Acc on 28.12.2024.
//

import Foundation
import CoreData

struct PersistentController {
    
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    
    init() {
        container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }
}
