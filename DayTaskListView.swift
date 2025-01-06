//
//  DayTaskListView.swift
//  TaskManager
//
//  Created by vakhram on 02.01.2025.
//

import SwiftUI

struct DayTaskListView: View {
    @ObservedObject var viewModel: TaskManagerViewModel
    @State var isExpanded: Bool = false
    var count = 0
    
    var body: some View {
        DisclosureGroup("Your Tasks") {
            ForEach(viewModel.sortedTasks, id: \.0) { group in
                if let date = group.0 {
                    DisclosureGroup("\(date)") {
                        ForEach(group.1, id: \.id) { task in
                            TaskView(viewModel: viewModel, task: task)
                        }
                    }
                }
            }
        }
    }
}
