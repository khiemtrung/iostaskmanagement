//
//  Task.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var dueDate: Date
    var priority: TaskPriority
    var category: TaskCategory
    var isCompleted: Bool = false
}

enum TaskPriority: String {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

enum TaskCategory: String {
    case work = "Work"
    case personal = "Personal"
    case other = "Other"
}
