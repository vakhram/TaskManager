//
//  File.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct AddTaskButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack {
            NavigationLink(destination: AddTaskView().environment(\.managedObjectContext, viewContext)) {
                    Text("+ New Task")
                }
                .padding(15)
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
        }
        .padding(.top)
    }
}
