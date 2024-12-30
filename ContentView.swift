//
//  ContentView.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: TaskManagerViewModel = TaskManagerViewModel(context: PersistentController.shared.container.viewContext)
    
    var body: some View {
        return NavigationView {
            VStack {
                Text("Vakhram Task Manager")
                    .font(.system(size: 27, weight: .bold))
                    .padding(25)
                UncompletedTasks(viewModel: viewModel, tasks: viewModel.tasks)
                CompletedTasks(viewModel: viewModel, tasks: viewModel.tasks)
                AddTaskButton(viewModel: viewModel)
            } .onAppear {
                viewModel.fetchTasks()
            }
        }

    }
}

struct UncompletedTasks: View {
    
    @ObservedObject var viewModel: TaskManagerViewModel
    let tasks: [TaskClass]
    
    var body: some View {
        Form {
            DisclosureGroup("Your Tasks") {
                ForEach(tasks.filter({!$0.isCompleted}), id: \.id) { task in
                    TaskView(viewModel: viewModel, task: task)
                }
            }
        }
        .background(.black)
    }
}

struct CompletedTasks: View {
    
    @ObservedObject var viewModel: TaskManagerViewModel
    var tasks: [TaskClass]
    
    var body: some View {
        Form {
            DisclosureGroup("Completed Tasks") {
                ForEach(tasks.filter({$0.isCompleted}), id: \.id) { task in
                    TaskView(viewModel: viewModel
                             , task: task)
                }
            }
        }
    }
}

struct TaskView: View {
    @ObservedObject var viewModel: TaskManagerViewModel
    var task: TaskClass
    
    var body: some View {
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
                                    debugPrint(task)
                                }
                            }
            if let date = task.deadlineDay {
                Text(task.taskName + " \(DateFormatter.createdateFormatter(with: .date).string(from: date))")
            } else {
                Text(task.taskName)
            }
        }
    }
}

#Preview {
    ContentView()
}
