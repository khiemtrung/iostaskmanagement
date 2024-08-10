//
//  CalendarViewController.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import UIKit
import CalendarKit
import RealmSwift

class CalendarViewController: DayViewController {
    var taskViewModel: TaskViewModel!
    var selectedDate: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar"
        dayView.autoScrollToFirstEvent = true
        dayView.dataSource = self
    }

    // Override this method to provide events to the DayView
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        // Fetch tasks for the selected date
        let tasks = taskViewModel.tasks.filter { Calendar.current.isDate($0.dueDate, inSameDayAs: date) }
        
        // Convert tasks to EventDescriptors
        var events: [Event] = []
        for task in tasks {
            let event = Event()
            event.dateInterval = DateInterval(start: task.dueDate, duration: 3600) // 1 hour duration
            event.text = "\(task.name)\n\(task.taskDescription)"
            event.color = .systemBlue
            events.append(event)
        }
        return events
    }

    func reloadTasks() {
        dayView.reloadData()
    }
}
