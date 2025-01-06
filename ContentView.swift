//
//  ContentView.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: TaskManagerViewModel = TaskManagerViewModel(context: PersistentController.shared.container.viewContext)
    @State var isEditing: Bool = false
    @State var isDeleting: Bool = false
    @State var selectedTask: TaskClass?

    @ViewBuilder
    var body: some View {
        return NavigationStack {
            VStack {
                ScrollView {
                    TaskListView(viewModel: viewModel, type: .uncompleted)
                    TaskListView(viewModel: viewModel, type: .completed)
                }
                TasksButton(viewModel: viewModel, type: .add    )
            }
            .navigationTitle("Vakhram Task Manager")
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Edit") {
//                        isEditing.toggle()
//                    }
//                }
//            }
            .onAppear {
                viewModel.fetchTasks()
            }
        }
    }
}

struct TaskView: View {
    @ObservedObject var viewModel: TaskManagerViewModel
    var dateFormatter: DateFormatter = .createdateFormatter(with: .date)
    var task: TaskClass
    @State var isOnToggle: Bool = false
    
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
                if let date = task.deadlineDay {
                    NavigationLink(destination: EditTaskView(viewModel: viewModel, currentTask: task)) {
                        Text(task.taskName + " \(DateFormatter.createdateFormatter(with: .date).string(from: date))")
                    }
                } else {
                    NavigationLink(destination: EditTaskView(viewModel: viewModel, currentTask: task)) {
                        Text(task.taskName)
                    }
                }
            }
        } .toggleStyle(CheckBoxToggleStyle())
    }
}

#Preview {
    ContentView(viewModel: TaskManagerViewModel(context: PersistentController.shared.container.viewContext))
}
