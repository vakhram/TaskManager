//
//  PersistentController.swift
//  TaskManager
//
//  Created by vakhram on 06.01.2025.
//

import Foundation
import CoreData

class PersistentController {
    
    static var shared = PersistentController()
    let container = NSPersistentContainer(name: "TaskModel")
    
    init() {
        let container = NSPersistentContainer(name: "TaskModel")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }
}
