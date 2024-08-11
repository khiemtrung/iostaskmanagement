# iostaskmanagement
A visually appealing and intuitive task management app for iOS devices.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Requirements](#requirements)
- [Design Decisions](#design-decisions)
- [Future Improvements](#future-improvements)
- [Screenshots](#screenshots)
- [Video Demonstration](#video-demonstration)

## Features

- Modern, sleek interface for managing tasks.
- Three main screens: Task List, Task Details, and Add/Edit Task.
- Visually appealing representation of task priorities (color coding and icons).
- Custom calendar view for task due dates using the CalendarKit library.
- CRUD functionality: Create, Read, Update, and Delete tasks.
- Task categorization (e.g., work, personal).
- Ability to set reminders for tasks with local notifications.
- Dashboard view showing task statistics (completed vs. pending).
- Drag-and-drop functionality for reordering tasks with animation.
- Support for subtasks with an expandable/collapsible UI.

## Technologies Used

- Swift
- SwiftUI
- ReamlSwift for persistent storage
- UserNotifications for managing reminders
- CalendarKit for custom calendar views
- SwiftIUChart for Dashboard chart 

## Installation

To run this project locally, follow these steps:

1. Clone this repository:
   git clone https://github.com/yourusername/task-management-app.git

2. Run "pod install"

3. Open the project in Xcode:
   open iostaskmanagement.xcodeproj

4. Build and run the app on a simulator or physical device.

## Usage

1. Launch the app on your device or simulator.
2. Create new tasks, categorize them, and set due dates and reminders.
3. Drag and drop tasks to reorder them in the list.
4. View task statistics on the dashboard.
5. Explore task details and edit or delete tasks as needed.

## Requirements

| **Requirement Category**         | **Requirement**                                                                                       | **Status**                              | **Notes**                                      |
|----------------------------------|-------------------------------------------------------------------------------------------------------|-----------------------------------------|------------------------------------------------|
| **UI/UX (Primary Focus)**        | **Design a modern, sleek interface for managing tasks.**                                            | ✅ Completed                            | UI is visually appealing                       |
|                                  | **Implement at least three screens: Task List, Task Details, and Add/Edit Task.**                    | ✅ Completed                            | All three screens available                    |
|                                  | **Implement a visually appealing way to represent task priorities (e.g., color coding, icons).**      | ✅ Completed                            | Task priorities are visually represented        |
|                                  | **Create a custom calendar view for task due dates.**                                                | ✅ Completed                            | CalendarKit is integrated                      |
| **Functionality**                | **Allow users to create, read, update, and delete tasks.**                                          | ✅ Completed                            | CRUD operations available                       |
|                                  | **Implement task categorization (work, personal, etc.).**                                            | ✅ Completed                            | Categories added to task model                 |
|                                  | **Add the ability to set reminders for tasks.**                                                      | ✅ Completed                            | Reminder functionality added                   |
|                                  | **Create a dashboard view showing task statistics (e.g., completed vs. pending tasks).**              | ✅ Completed                      | Dashboard added in Bottom Menu                           |
| **Bonus Points (Optional)**      | **Implement data for persistent storage.**                                                            | ✅ Completed                            | Realm is set up                               |
|                                  | **Add haptic feedback for user interactions.**                                                        | ✅ Completed                            | Haptic feedback for save task, drag-and-drop task, and tap on tab bar menu items |
|                                  | **Create a visually appealing onboarding experience for first-time users.**                           | ✅ Completed                      | Implemented                           |
|                                  | **Implement drag-and-drop functionality for reordering tasks.**                                      | ✅ Completed                            | Drag-and-drop functionality added              |
|                                  | **Add support for subtasks with an expandable/collapsible UI.**                                      | ✅ Completed                            | Added subtask feature to Add/Edit screen and TaskDetailView |

## Design Decisions

- **UI/UX Design**: Focused on a clean, modern look to enhance usability and user experience.
- **Color Coding**: Implemented color-coded priorities for quick visual identification of task importance.
- **Custom Calendar View**: Utilized CalendarKit for an intuitive and interactive calendar experience.
- **Local Notifications**: Used UserNotifications framework for reminders to keep users informed about task deadlines.

## Future Improvements

- Fix bug for some time re-order not update correct posisition
- Action for show specific list when tap on Dashboard view
- Delete sub-task
- Optimize UI

## Screenshots
![Task List Screen](https://i.imgur.com/g54DDr0.png)
![Task Screen with expandable sub-task](https://i.imgur.com/80qM9vo.png)
![Task Detail Screen](https://i.imgur.com/80qM9vo.png)
![Dashboard Screen](https://i.imgur.com/o9LVxhK.png)
![Calendar Screen](https://i.imgur.com/ue2SnBV.png)
![Delete and re-arrange task](https://i.imgur.com/SDfwebR.png)
![Add/Edit screen](https://i.imgur.com/wiQtyBz.png)

## Video Demonstration
[Link to video demonstration](https://www.youtube.com/watch?v=GLi3wT4WeNo)

