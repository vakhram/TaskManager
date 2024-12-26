//
//  ContentView.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskClass.deadlineDay, ascending: true)],
        animation: .default
    ) private var tasks: FetchedResults<TaskClass>
    
    @ViewBuilder
    var body: some View {
        let taskArray: [TaskClass] = Array(tasks)
        NavigationView {
            VStack {
                Text("Vakhram Task Manager")
                    .font(.system(size: 27, weight: .bold))
                    .padding(25)
                TodayTasks(tasks: taskArray)
                AddTaskButton()
                    .environment(\.managedObjectContext, viewContext)
            }
        }

    }
}

struct TodayTasks: View {
    let tasks: [TaskClass]
    
    var body: some View {
        Form {
            DisclosureGroup("Your Tasks") {
                ForEach(tasks, id: \.id) { task in
                    TaskView(task: task)
                }
            }
        }
    }
}

struct TaskView: View {
    var dateFormatter: DateFormatter = .createdateFormatter(with: .date)
    var task: TaskClass
    @State var isOnToggle: Bool = false
    
    var body: some View {
        Toggle(isOn: $isOnToggle) {
            if let date = task.deadlineDay{
                Text(task.taskName + " \(dateFormatter.string(from: date))")
            }
        } .toggleStyle(CheckBoxToggleStyle())
    }
}

#Preview {
    ContentView()
}
