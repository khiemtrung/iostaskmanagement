//
//  AddEditTaskView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//
import UIKit
import SwiftUI
import UserNotifications
import RealmSwift

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
    @State private var newSubtaskName: String = ""
    @State private var subtasks: [Subtask] = [] // List to hold subtasks
    
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
            
            Section(header: Text("Subtasks")) {
                ForEach(subtasks, id: \.id) { subtask in
                    HStack {
                        Text(subtask.name)
                            .font(.subheadline)
                        Spacer()
                        Button(action: {
                            // Toggle completion status
                            //subtask.isCompleted.toggle()
                        }) {
                            Image(systemName: subtask.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                    }
                }
                
                HStack {
                    TextField("New Subtask", text: $newSubtaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        addSubtask()
                    }) {
                        Text("Add")
                    }
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
                
                // Load existing subtasks
                subtasks = Array(task.subtasks) // Convert List<Subtask> to [Subtask]
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Missing Title"), message: Text("Please enter a task name."), dismissButton: .default(Text("OK")))
        }
    }
    
    private func addSubtask() {
           let newSubtask = Subtask()
           newSubtask.name = newSubtaskName
           subtasks.append(newSubtask)
           newSubtaskName = "" // Clear the input
       }
    
    
    private var saveButton: some View {
        Button(action: {
            triggerHapticFeedback()
            // Validate that task name is not empty
            if taskName.isEmpty {
                showAlert = true
                return
            }
            
            if let existingTask = task {
                // Update the existing task
                let realm = try! Realm()
                                try! realm.write {
                                    existingTask.name = taskName
                                    existingTask.taskDescription = taskDescription
                                    existingTask.dueDate = dueDate
                                    existingTask.priority = priority.rawValue
                                    existingTask.category = category.rawValue
                                    existingTask.reminderDate = reminderDate

                                    // Clear existing subtasks from the task
                                    existingTask.subtasks.removeAll()

                                    // Add new subtasks
                                    for subtask in subtasks {
                                        let subtaskToAdd = Subtask()
                                        subtaskToAdd.name = subtask.name
                                        subtaskToAdd.isCompleted = subtask.isCompleted // Preserve completion state
                                        existingTask.subtasks.append(subtaskToAdd)
                                    }
                                }
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
                
                // Add the subtasks to the new task
                for subtask in subtasks {
                    taskViewModel.addSubtask(to: newTask, withName: subtask.name)
                }
                
                // Add the task to the view model
                taskViewModel.addTask(newTask)
            }
            
            // Dismiss the view
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
    
    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}
