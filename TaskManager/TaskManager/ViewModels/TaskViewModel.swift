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
    
    // Delete task from Realm and refresh the task list
        func deleteTask(_ task: Task) {
            guard let taskToDelete = realm.object(ofType: Task.self, forPrimaryKey: task.id) else { return }
            try! realm.write {
                realm.delete(taskToDelete)
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
