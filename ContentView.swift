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
                ScrollView {
                    TaskListView(viewModel: viewModel, type: .uncompleted)
                    TaskListView(viewModel: viewModel, type: .completed)
                }
                AddTaskButton(viewModel: viewModel)
            } .onAppear {
                viewModel.fetchTasks()
            }
        }
        .preferredColorScheme(.dark)
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
