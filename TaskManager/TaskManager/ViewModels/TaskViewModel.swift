//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI
import RealmSwift
class TaskViewModel: ObservableObject {
    private var realm: Realm
    @Published var tasks: [Task] = []
    
    init() {
        realm = try! Realm()
        fetchTasks()
    }
    
    func fetchTasks() {
        let results = realm.objects(Task.self)
        tasks = Array(results)
    }
    
    func addTask(_ task: Task) {
           // Add task to Realm
           try! realm.write {
               realm.add(task)
           }
           fetchTasks() // Refresh the tasks list after adding a new task
       }
    
    func deleteTask(_ task: Task) {
        try! realm.write {
            realm.delete(task)
        }
        fetchTasks() // Refresh tasks
    }
    
    func completedTasks() -> [Task] {
            return tasks.filter { $0.isCompleted }
        }

        func incompleteTasks() -> [Task] {
            return tasks.filter { !$0.isCompleted }
        }
}
