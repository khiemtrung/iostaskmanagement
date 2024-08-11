//
//  SubTask.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 11/08/2024.
//

import Foundation
import RealmSwift

class Subtask: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var parentTask: Task? // Reference to the parent task
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
