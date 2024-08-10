//
//  AddEditTaskView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI
import UserNotifications

struct AddEditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var reminderDate: Date? = nil
    
    var task: Task?
    
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .medium
    @State private var category: TaskCategory = .work
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $taskName)
                TextField("Description", text: $taskDescription)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                    .environment(\.locale, Locale(identifier: "en_GB")) // Optional: Set locale for 24-hour format
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
            
            Section(header: Text("Reminder")) {
                Toggle(isOn: Binding(
                    get: { reminderDate != nil },
                    set: { if $0 { reminderDate = Date() } else { reminderDate = nil } }
                )) {
                    Text("Set Reminder")
                }
                
                if let unwrappedReminderDate = reminderDate {
                    DatePicker("Reminder Date", selection: Binding(
                        get: { unwrappedReminderDate },
                        set: { reminderDate = $0 }
                    ), displayedComponents: [.date, .hourAndMinute])
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
                reminderDate = task.reminderDate // Populate reminder date if editing
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Missing Title"), message: Text("Please enter a task name."), dismissButton: .default(Text("OK")))
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            // Validate that task name is not empty
            if taskName.isEmpty {
                showAlert = true
                return
            }
            
            if let existingTask = task {
                // Update the existing task
                taskViewModel.editTask(existingTask, withName: taskName, description: taskDescription, dueDate: dueDate, priority: priority.rawValue, category: category.rawValue, reminderDate: reminderDate)
            } else {
                // Create a new task with the unique order
                let newOrder: Int
                let currentTasks = taskViewModel.tasks
                if let maxOrder = currentTasks.map({ $0.order }).max() {
                    newOrder = maxOrder + 1 // Set new order to max + 1
                } else {
                    newOrder = 0 // If no tasks exist, start from 0
                }
                
                // Create a new task
                let newTask = Task()
                newTask.name = taskName
                newTask.taskDescription = taskDescription
                newTask.dueDate = dueDate
                newTask.priority = priority.rawValue
                newTask.category = category.rawValue
                newTask.isCompleted = false
                newTask.order = newOrder // Set the unique order
                newTask.reminderDate = reminderDate // Set reminder date
                
                // Add the task to the view model
                taskViewModel.addTask(newTask)
                
            }
            
            // Dismiss the view
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
    
  
}
