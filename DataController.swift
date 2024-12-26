//
//  DataController.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TaskModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }
}
