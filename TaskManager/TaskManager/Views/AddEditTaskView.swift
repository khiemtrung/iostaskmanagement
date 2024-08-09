//
//  AddEditTaskView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct AddEditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskName: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .medium
    @State private var category: TaskCategory = .work

    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $taskName)
                TextField("Description", text: $description)
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
                    Text("Other").tag(TaskCategory.other)
                }
            }
        }
        .navigationBarTitle("Add Task", displayMode: .inline)
        .navigationBarItems(trailing: saveButton)
    }

    private var saveButton: some View {
        Button("Save") {
            // Save task logic
            presentationMode.wrappedValue.dismiss()
        }
    }
}
