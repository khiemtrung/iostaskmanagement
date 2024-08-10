//
//  TaskListView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskViewModel.tasks) { task in
                    // Use a constant to hold the index
                   
                    NavigationLink(destination: TaskDetailsView(taskViewModel: taskViewModel, task: task)) {
                        TaskRowView(task: task)
                    }
                }
                .onDelete(perform: deleteTasks)
                .onMove(perform: moveTask)
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(trailing: HStack {
                EditButton()
                addButton
            })
        }
        .onAppear {
            taskViewModel.fetchTasks() // Call fetchTasks() when the view appears
        }
    
    }
    
    private var addButton: some View {
        NavigationLink(destination: AddEditTaskView(taskViewModel: taskViewModel)) {
            Image(systemName: "plus")
        }
    }
    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let taskToDelete = taskViewModel.tasks[index]
            taskViewModel.deleteTask(taskToDelete)
        }
    }
    
    private func moveTask(from source: IndexSet, to destination: Int) {
            taskViewModel.moveTask(from: source, to: destination) // Call the moveTask function in the ViewModel
        }
}

struct TaskRowView: View {
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text(task.taskDescription) // Use taskDescription instead of description
                    .font(.subheadline)
                Text(task.dueDate, style: .date)
                    .font(.subheadline)
//                Text("\(task.order)")
//                    .font(.subheadline)
            }
            Spacer()
            Circle()
                .fill(priorityColor(for: TaskPriority(rawValue: task.priority) ?? .low)) // Convert string back to enum
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
