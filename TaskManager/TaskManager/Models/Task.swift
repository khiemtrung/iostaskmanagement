//
//  Task.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import Foundation
import RealmSwift

class Task: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var taskDescription = "" // Rename to avoid conflict with Swift's keyword
    @objc dynamic var dueDate = Date()
    @objc dynamic var priority = TaskPriority.low.rawValue // Store as String or enum
    @objc dynamic var category = TaskCategory.work.rawValue // Store as String or enum
    @objc dynamic var isCompleted = false
    @objc dynamic var isDeleted = false

    override static func primaryKey() -> String? {
        return "id"
    }
}

enum TaskPriority: String {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

enum TaskCategory: String {
    case work = "Work"
    case personal = "Personal"
    case others = "Others"
}
