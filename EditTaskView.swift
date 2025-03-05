//
//  EditTaskView.swift
//  TaskManager
//
//  Created by vakhram on 03.01.2025.
//

import SwiftUI
import CoreData

struct EditTaskView: View {
    
    @ObservedObject var viewModel: TaskManagerViewModel
    var currentTask: TaskClass
    
    @State private var taskNameString: String = ""
    @State private var taskDescriprion: String = ""
    @State private var taskDeadlineDay: Date = .now
    @State private var taskDeadlineTime: Date = .now
    
    @State private var isPresenting: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField(text: $taskNameString) {
                        Text(taskNameString)
                    }
                    DatePicker(selection: $taskDeadlineDay, displayedComponents: [.date]) {
                        Text("Deadline Day")
                    }
                    DatePicker(selection: $taskDeadlineTime, displayedComponents: [.hourAndMinute]) {
                        Text("Deadline Time")
                    }
                } 
                .datePickerStyle(.graphical)
                HStack {
                    Button ("Delete Task") {
                        deleteTask(task: currentTask, from: viewModel.context)
                    }.buttonStyle(BlueButton())
                    Button ("Save Task") {
                        editTask(atIndex: findIndexOfTask(task: currentTask), taskName: taskNameString, deadlineDay: taskDeadlineDay, deadlineTime: taskDeadlineTime, context: viewModel.context)
                    } .buttonStyle(BlueButton())
                }
            }
            .navigationTitle("Edit a task")
        } .onAppear(perform: {
            fetchTask(task: currentTask)
        })
    }
    
    private func findIndexOfTask(task: TaskClass) -> Int? {
        viewModel.tasks.firstIndex { currentTask in
            currentTask.id == task.id
        }
    }
    
    private func fetchTask(task: TaskClass) {
        taskNameString = currentTask.taskName
        taskDescriprion = currentTask.description
        taskDeadlineDay = currentTask.deadlineDay ?? .now
        taskDeadlineTime = currentTask.deadlineTime ?? .now
    }
    
    private func editTask(atIndex: Int?, taskName: String?, deadlineDay: Date?, deadlineTime: Date?, context: NSManagedObjectContext) {
        guard let index = atIndex else { return }
        let task = viewModel.tasks[index]
        task.taskName = taskName ?? "🥵"
        task.deadlineDay = deadlineDay
        task.deadlineTime = deadlineTime
        task.isCompleted = false
        
        do {
            try context.save()
            dismiss()
            print("success")
        } catch {
            print("Failed to save task: \(error.localizedDescription)")
        }
    }
    //TODO: Make Alert after deleting and editing
//    @ViewBuilder
//    private func makeAlert() -> some View {
//        alert(
//            Text("Task Deleted"),
//            isPresented: $isPresenting) {
//                Button("Ok") {
//                    dismiss()
//                }
//            } message: {
//                Text("Task Deleted Successfully")
//            }
//    }
    
    private func deleteTask(task: TaskClass, from context: NSManagedObjectContext) {
        context.delete(task)
        
        do {
            try context.save()
            dismiss()
        } catch {
            print("DELETED UNSUCCESSFULLY")
        }
    }
 }

#Preview {
    EditTaskView(viewModel: TaskManagerViewModel(context: PersistentController.shared.container.viewContext), currentTask: TaskClass(context: PersistentController.shared.container.viewContext))
}
