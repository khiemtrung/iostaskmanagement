//
//  AddEditTaskView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI


struct AddEditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel
    
    var task: Task?
    
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .medium
    @State private var category: TaskCategory = .work
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $taskName)
                TextField("Description", text: $taskDescription)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority) {
                    Text("High").tag(TaskPriority.high)
                    Text("Medium").tag(TaskPriority.medium)
                    Text("Low").tag(TaskPriority.low)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Category")) {
                Picker("Category", selection: $category) {
                    Text("Work").tag(TaskCategory.work)
                    Text("Personal").tag(TaskCategory.personal)
                    Text("Other").tag(TaskCategory.others)
                }
            }
        }
        .navigationBarTitle(task == nil ? "Add Task" : "Edit Task", displayMode: .inline)
        .navigationBarItems(trailing: saveButton)
        .onAppear {
            // Populate fields if editing an existing task
            if let task = task {
                taskName = task.name
                taskDescription = task.taskDescription
                dueDate = task.dueDate
                priority = TaskPriority(rawValue: task.priority) ?? .medium
                category = TaskCategory(rawValue: task.category) ?? .work
            }
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            // Fetch the current highest order value
            let currentTasks = taskViewModel.tasks
            let newOrder: Int
            if let maxOrder = currentTasks.map({ $0.order }).max() {
                newOrder = maxOrder + 1 // Set new order to max + 1
            } else {
                newOrder = 0 // If no tasks exist, start from 0
            }
            
            // Create a new task with the unique order
            let newTask = Task()
            newTask.name = taskName
            newTask.taskDescription = taskDescription
            newTask.dueDate = dueDate
            newTask.priority = priority.rawValue
            newTask.category = category.rawValue
            newTask.isCompleted = false
            newTask.order = newOrder // Set the unique order
            
            // Add the task to the view model
            taskViewModel.addTask(newTask)
            
            // Dismiss the view
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
}
