//
//  TaskListView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = [] // Replace with your model

    var body: some View {
        NavigationView {
            List(tasks) { task in
                NavigationLink(destination: TaskDetailsView(task: task)) {
                    TaskRowView(task: task)
                }
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(trailing: addButton)
        }
    }

    private var addButton: some View {
        NavigationLink(destination: AddEditTaskView()) {
            Image(systemName: "plus")
        }
    }
}

struct TaskRowView: View {
    var task: Task

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text(task.dueDate, style: .date)
                    .font(.subheadline)
            }
            Spacer()
            // Add color-coded priority indicator
            Circle()
                .fill(priorityColor(for: task.priority))
                .frame(width: 20, height: 20)
        }
        .padding(.vertical, 8)
    }

    private func priorityColor(for priority: TaskPriority) -> Color {
        switch priority {
        case .high: return .red
        case .medium: return .yellow
        case .low: return .green
        }
    }
}
#Preview {
    ContentView()
}
