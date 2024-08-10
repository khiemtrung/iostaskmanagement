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
        
        let results = realm.objects(Task.self).filter("isDeleted == false").sorted(byKeyPath: "order")
        tasks = Array(results)
    }
    
    func addTask(_ task: Task) {
        // Determine the highest current order value, including deleted tasks
        let currentMaxOrder = realm.objects(Task.self).map { $0.order }.max() ?? 0
        task.order = currentMaxOrder + 1 // Set the order for the new task
        
        // Add task to Realm
        try! realm.write {
            realm.add(task)
        }
        fetchTasks() // Refresh the tasks list after adding a new task
    }
    
    // Update an existing task in Realm
    func editTask(_ task: Task, withName name: String, description: String, dueDate: Date, priority: String, category: String) {
        try! realm.write {
            task.name = name
            task.taskDescription = description
            task.dueDate = dueDate
            task.priority = priority
            task.category = category
        }
        fetchTasks() // Refresh tasks
    }
    
    // Delete task from Realm and refresh the task list
    func deleteTask(_ task: Task) {
        guard let taskToDelete = realm.object(ofType: Task.self, forPrimaryKey: task.id) else { return }
        do {
            try realm.write {
                //realm.delete(taskToDelete)
                taskToDelete.isDeleted = true
            }
            fetchTasks() // Refresh tasks
        } catch {
            print("Error deleting task: \(error.localizedDescription)")
        }
    }
    
    func updateTaskCompletionStatus(task: Task, isCompleted: Bool) {
        try! realm.write {
            task.isCompleted = isCompleted
        }
        fetchTasks()
    }
    
    func completedTasks() -> [Task] {
        return tasks.filter { $0.isCompleted }
    }
    
    func incompleteTasks() -> [Task] {
        return tasks.filter { !$0.isCompleted }
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        // Get the tasks that are being moved
        let tasksToMove = source.map { tasks[$0] }
        
        // Update the tasks array to reflect the new order
        tasks.move(fromOffsets: source, toOffset: destination)
        
        do {
            try realm.write {
                // Reset the order for all tasks
                for (index, task) in tasks.enumerated() {
                    if let affectedTask = realm.object(ofType: Task.self, forPrimaryKey: task.id) {
                        affectedTask.order = index + 1 // Adjusting to start order from 1
                    }
                }
            }
        } catch {
            print("Error updating task order: \(error.localizedDescription)")
        }
        
        fetchTasks() // Refresh the task list if needed
    }

}
