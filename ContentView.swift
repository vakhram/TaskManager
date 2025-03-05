//
//  ContentView.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel: TaskManagerViewModel = TaskManagerViewModel(context: PersistentController.shared.container.viewContext)
        
    var body: some View {
        NavigationView {
            List {
                ScrollView {
//                    TaskListView(viewModel: viewModel, type: .uncompleted)
//                    TaskListView(viewModel: viewModel, type: .completed)
                    DayTaskListView(viewModel: viewModel, type: .uncompleted)
                    DayTaskListView(viewModel: viewModel, type: .completed)
                }
            }
            .toolbar(content: {
                ToolbarItem {
                    NavigationLink(destination: AddTaskView(viewModel: viewModel)) {
                        Label("Add image", systemImage: "plus")
                    }
                }
            })
            .navigationTitle("Vakhram Task Manager")
            .task {
                viewModel.fetchTasks()
            }
        }
        .preferredColorScheme(.light)
    }
}

struct TaskView: View {
    @ObservedObject var viewModel: TaskManagerViewModel
    var task: TaskClass
    
    var body: some View {
        NavigationView {
            HStack {
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(lineWidth: 2)
                    .frame(width: 25, height: 25)
                    .cornerRadius(5.0)
                    .overlay {
                        Image(systemName: task.isCompleted ? "checkmark" : "")
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.toggleTaskCompletion(task)
                        }
                    }
                NavigationLink(destination: EditTaskView(viewModel: viewModel, currentTask: task)) {
                    Text(task.deadlineTime == nil ? task.taskName : task.taskName + " \(DateFormatter.createdateFormatter(with: .time).string(from: task.deadlineTime!))")
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: TaskManagerViewModel(context: PersistentController.shared.container.viewContext))
}
