//
//  ADdTaskView.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    
    @ObservedObject var viewModel: TaskManagerViewModel
    
    @State var taskNameString: String = ""
    @State var taskDescriprion: String = ""
    @State var taskDeadlineDay: Date = .now
    @State var taskDeadlineTime: Date = .now
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField(text: $taskNameString) {
                        Text("Name:")
                    }
                    TextField(text: $taskDescriprion) {
                        Text("Description")
                    }
                    DatePicker(selection: $taskDeadlineDay, displayedComponents: [.date]) {
                        Text("Deadline Day")
                    }
                }.datePickerStyle(.graphical)
                Button ("Create Task") {
                    createTask(taskName: taskNameString, deadlineDay: taskDeadlineDay, deadlineTime: taskDeadlineDay, context: viewModel.context)
                } .buttonStyle(BlueButton())
            } 
        }
    }
    
    func createTask(taskName: String?, deadlineDay: Date?, deadlineTime: Date?, context: NSManagedObjectContext) {
        let task = TaskClass(context: context)
            task.taskName = taskName ?? "🥵"
            task.deadlineDay = deadlineDay
            task.deadlineTime = deadlineTime
            task.isCompleted = false
            task.id = UUID()
//        "\(Int.random(in: 1..<100000))" + (["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"].randomElement() ?? "a")

            do {
                try context.save()
                print("success")
            } catch {
                print("Failed to save task: \(error.localizedDescription)")
            }
    }
 }

#Preview {
    AddTaskView(viewModel: TaskManagerViewModel(context: PersistentController.shared.container.viewContext) )
}
